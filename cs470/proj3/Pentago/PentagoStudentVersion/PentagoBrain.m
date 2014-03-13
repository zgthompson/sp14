//
//  PentagoBrain.m
//  PentagoStudentVersion
//
//  Zachary Thompson
//

#import "PentagoBrain.h"

@interface PentagoBrain ()

@property (nonatomic) BOOL player1Turn;
@property (nonatomic) BOOL rotationAllowed;
@property (nonatomic) BOOL hasWinner;
@property (nonatomic) NSMutableArray *board;
@property (nonatomic) NSDictionary *rotationMap;

@end

@implementation PentagoBrain

+(PentagoBrain *) sharedInstance
{
    static PentagoBrain *sharedObject = nil;
    
    if( sharedObject == nil )
        sharedObject = [[PentagoBrain alloc] init];
    return sharedObject;
}

-(id) init
{
    if (self = [super init]) {
        self.rotationMap = [NSDictionary dictionaryWithObjectsAndKeys:
                            [NSNumber numberWithInt:0], [NSNumber numberWithInt:2],
                            [NSNumber numberWithInt:1], [NSNumber numberWithInt:5],
                            [NSNumber numberWithInt:2], [NSNumber numberWithInt:8],
                            [NSNumber numberWithInt:3], [NSNumber numberWithInt:1],
                            [NSNumber numberWithInt:4], [NSNumber numberWithInt:4],
                            [NSNumber numberWithInt:5], [NSNumber numberWithInt:7],
                            [NSNumber numberWithInt:6], [NSNumber numberWithInt:0],
                            [NSNumber numberWithInt:7], [NSNumber numberWithInt:3],
                            [NSNumber numberWithInt:8], [NSNumber numberWithInt:6],
                            nil];
        
        self.board = [NSMutableArray arrayWithCapacity:36];
        
        for (int i = 0; i < 36; ++i) {
            [self.board addObject:[NSNull null]];
        }
    }

    return self;
}

-(void) sendNotificationIfWinner
{
    int winner = 0;
    if (
        (winner += [self horizontalWin]) > 0 ||
        (winner += [self verticalWin]) > 0 ||
        (winner += [self leftDiagonalWin]) > 0 ||
        (winner += [self rightDiagonalWin]) > 0
        )
    {
        self.hasWinner = YES;
        NSString *winnerString = winner == 1 ? @"Player 1" : @"Player 2";
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"PentagoWinner" object:winnerString];
    }
}

# pragma mark - Public methods

// Returns: YES if it is currently the first player's turn
-(BOOL) isPlayer1Turn
{
    return self.player1Turn;
}

// Updates the game board if the given move is valid
// Returns: YES if the desired move is valid, NO otherwise
-(BOOL) makeMoveIfValidOnBoard:(int)board atRow:(int)row andCol:(int)col
{
    if (self.hasWinner) return NO;
    
    int curIndex = [self indexForBoard:board atRow:row andCol:col];
    
    if (self.board[curIndex] != [NSNull null]) {
        return NO;
    }
    
    int curPlayer;
    
    // switch to the next players turn, and set curPlayer accordingly
    if (self.player1Turn) {
        self.player1Turn = NO;
        curPlayer = 2;
    }
    
    else {
        self.player1Turn = YES;
        curPlayer = 1;
    }
    
    self.board[curIndex] = [NSNumber numberWithInt:curPlayer];
    
    self.rotationAllowed = YES;
    
    [self sendNotificationIfWinner];
    
    return YES;
}

// If a rotation is allowed, then it updates the game board with a rotation in the specified direction
-(BOOL) makeRotationIfValidOnBoard:(int) board inDirection:(int) direction
{
    if (!self.rotationAllowed || self.hasWinner) return NO;
    
    if (direction == 1) {
        [self clockwiseRotationOnBoard:board];
    }
    
    else if (direction == -1) {
        [self counterClockwiseRotationOnBoard:board];
    }
    
    self.rotationAllowed = NO;
    
    [self sendNotificationIfWinner];
    
    return YES;
}

# pragma mark - Rotation logic

// Rotates the subboard in a clockwise direction
-(void) clockwiseRotationOnBoard:(int) board
{
    NSMutableArray* rotatedBoard = [NSMutableArray arrayWithCapacity:9];
    for (int i = 0; i < 9; ++i) [rotatedBoard addObject:[NSNull null]];
    
    int toMapIndex, fromMapIndex, toBoardIndex, fromBoardIndex;
    
    for (id key in self.rotationMap) {
        toMapIndex = [key integerValue];
        fromMapIndex = [[self.rotationMap objectForKey:key] integerValue];
        fromBoardIndex = [self indexForBoard:board atRow:fromMapIndex / 3 andCol:fromMapIndex % 3];
        
        rotatedBoard[toMapIndex] = self.board[fromBoardIndex];
        
    }
    
    for (int i = 0; i < 9; ++i) {
        toBoardIndex = [self indexForBoard:board atRow:i / 3 andCol:i % 3];
        self.board[toBoardIndex] = rotatedBoard[i];
    }
}

// Rotates the subboard in the counter clockwise direction
-(void) counterClockwiseRotationOnBoard:(int) board
{
    NSMutableArray* rotatedBoard = [NSMutableArray arrayWithCapacity:9];
    for (int i = 0; i < 9; ++i) [rotatedBoard addObject:[NSNull null]];
    
    int toMapIndex, fromMapIndex, toBoardIndex, fromBoardIndex;
    
    for (id key in self.rotationMap) {
        fromMapIndex = [key integerValue];
        toMapIndex = [[self.rotationMap objectForKey:key] integerValue];
        fromBoardIndex = [self indexForBoard:board atRow:fromMapIndex / 3 andCol:fromMapIndex % 3];
        
        rotatedBoard[toMapIndex] = self.board[fromBoardIndex];
        
    }
    
    for (int i = 0; i < 9; ++i) {
        toBoardIndex = [self indexForBoard:board atRow:i / 3 andCol:i % 3];
        self.board[toBoardIndex] = rotatedBoard[i];
    }
}

# pragma mark - Winning logic

-(int) horizontalWin
{
    for (int row = 0; row < 6; ++row) {
        
        int inARow = 0;
        int player = 0;
        
        for (int col = 0; col < 6; ++col) {
            
            int curIndex = row * 6 + col;
            
            if (self.board[curIndex] == [NSNull null]) {
                if (col > 0) break;
                else {
                    inARow = 0;
                    player = 0;
                }
            }
            
            else {
            
                int curValue = [self.board[row * 6 + col] integerValue];
            
                if (curValue == player) {
                    if (++inARow == 5 && player != 0)
                        return player;
                }
                else {
                    inARow = 1;
                    player = curValue;
                }
            }
        }
        
    }
    
    return 0;
}

-(int) verticalWin
{
    for (int col = 0; col < 6; ++col) {
        
        int inARow = 0;
        int player = 0;
        
        for (int row = 0; row < 6; ++row) {
            
            int curIndex = row * 6 + col;
            
            if (self.board[curIndex] == [NSNull null]) {
                if (row > 0) break;
                else {
                    inARow = 0;
                    player = 0;
                }
            }
            
            else {
                
                int curValue = [self.board[row * 6 + col] integerValue];
                
                if (curValue == player) {
                    if (++inARow == 5 && player != 0)
                        return player;
                }
                else {
                    inARow = 1;
                    player = curValue;
                }
            }
        }
        
    }
    
    return 0;
}

-(int) leftDiagonalWin
{
    int startIndices[] = {4, 5, 10, 11};
    
    for (int i = 0; i < 4; ++i) {
        
        int startIndex = startIndices[i];
        int inARow = 0;
        int player = 0;
        
        for (int j = 0; j < 5; ++j) {
            
            int curIndex = startIndex + j * 6 - j;
            
            if (self.board[curIndex] == [NSNull null]) break;
            else {
                int curValue = [self.board[curIndex] integerValue];
                if (j == 0) player = curValue;
                if (player != curValue) break;
                else {
                    ++inARow;
                }
            }
        }
        
        if (inARow == 5) return player;
    }
    return 0;
}

-(int) rightDiagonalWin
{
    int startIndices[] = {0, 1, 6, 7};
    
    for (int i = 0; i < 4; ++i) {
        
        int startIndex = startIndices[i];
        int inARow = 0;
        int player = 0;
        
        for (int j = 0; j < 5; ++j) {
            
            int curIndex = startIndex + j * 6 + j;
            
            if (self.board[curIndex] == [NSNull null]) break;
            else {
                int curValue = [self.board[curIndex] integerValue];
                if (j == 0) player = curValue;
                if (player != curValue) break;
                else {
                    ++inARow;
                }
            }
        }
        
        if (inARow == 5) return player;
    }
    return 0;
}

# pragma mark - Helper methods

// Returns: the index of the 0 position of the 3x3 subboard in the 6x6 board representation
-(int) startIndexForBoard:(int) board
{
    return (board % 2) * 3 + (board / 2) * 18;
}

// Returns: returns the index of the 6x6 board for given the subboard, row, and col
-(int) indexForBoard:(int) board atRow:(int) row andCol:(int) col
{
    return [self startIndexForBoard:board] + row * 6 + col;
}

-(void) boardLog
{
    for (int i = 0; i < 6; ++i) {
        NSMutableString* curString = [NSMutableString stringWithString:@""];
        for (int j = 0; j < 6; ++j) {
            [curString appendFormat:@"%@ ", self.board[6 * i + j]];
        }
        NSLog(@"%@", curString);
    }
    
    
}

@end
