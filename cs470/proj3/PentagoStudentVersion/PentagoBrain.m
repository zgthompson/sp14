//
//  PentagoBrain.m
//  PentagoStudentVersion
//
//  Created by AAK on 2/17/14.
//  Copyright (c) 2014 Ali Kooshesh. All rights reserved.
//

#import "PentagoBrain.h"

@interface PentagoBrain ()

@property (nonatomic) BOOL player1Turn;
@property (nonatomic) BOOL rotationAllowed;
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

// Updates the game board if the given move is valid
// Returns: YES if the desired move is valid, NO otherwise
-(BOOL) makeMoveIfValidOnBoard:(int)board atRow:(int)row andCol:(int)col
{
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
    
    if ([self hasWinner]) {
        NSLog(@"WINNER!");
    }
    
    return YES;
}

-(BOOL) isPlayer1Turn
{
    return self.player1Turn;
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

-(BOOL) makeRotationIfValidOnBoard:(int) board inDirection:(int) direction
{
    if (!self.rotationAllowed) return NO;
    
    if (direction == 1) {
        [self clockwiseRotationOnBoard:board];
    }
    
    else if (direction == -1) {
        [self counterClockwiseRotationOnBoard:board];
    }
    
    self.rotationAllowed = NO;
    
    return YES;
}

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

-(int) startIndexForBoard:(int) board
{
    return (board % 2) * 3 + (board / 2) * 18;
}

-(int) indexForBoard:(int) board atRow:(int) row andCol:(int) col
{
    return [self startIndexForBoard:board] + row * 6 + col;
}

-(BOOL) hasWinner
{
    return [self horizontalWin] || [self verticalWin] || [self leftDiagonalWin] || [self rightDiagonalWin];
}

-(BOOL) horizontalWin
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
                        return YES;
                }
                else {
                    inARow = 1;
                    player = curValue;
                }
            }
        }
        
    }
    
    return NO;
}

-(BOOL) verticalWin
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
                        return YES;
                }
                else {
                    inARow = 1;
                    player = curValue;
                }
            }
        }
        
    }
    
    return NO;
}

-(BOOL) leftDiagonalWin
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
        
        if (inARow == 5) return YES;
    }
    return NO;
}

-(BOOL) rightDiagonalWin
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
        
        if (inARow == 5) return YES;
    }
    return NO;
}

@end
