//
//  PuzzleModel.m
//  FifteenPuzzle
//
//  Created by student on 2/15/14.
//  Copyright (c) 2014 zgt. All rights reserved.
//

#import "PuzzleModel.h"

@interface PuzzleModel ()

// board state representation
@property (nonatomic) NSMutableArray *board;
@property (nonatomic) NSArray *solutionBoard;

// current position of the blank piece
@property (nonatomic) int blankPos;
@property (nonatomic) int lastBlankPos;

@end

@implementation PuzzleModel


-(id)initWithBoard:(NSArray *)board
{
    if (self = [super init]) {
        
        [self setSolutionBoard:board];
        
        [self setBoard:[self.solutionBoard mutableCopy]];
        
        self.blankPos = 15;
        self.lastBlankPos = -1;
    }
    
    return self;
}


// Returns: YES if board is in the solved position, NO otherwise
-(BOOL) isSolved
{
    
    for (int i = 0; i < self.board.count; i++) {
        
        if ([self.board objectAtIndex:i] != [self.solutionBoard objectAtIndex:i]) {
            return NO;
        }
    }
    
    return YES;
}


// Bring the board back to the original state
// Returns: An array of arrays that each contain the two buttons that were swapped
-(NSArray*)resetBoard
{
    NSMutableArray *moveSequence = [NSMutableArray array];
    
    for (int i = 0; i < self.board.count; ++i) {
        UIButton *currentTile = self.board[i];
        UIButton *correctTile = self.solutionBoard[i];
        
        if (currentTile != correctTile) {
            NSUInteger posOfCorrect = [self.board indexOfObject:correctTile];
            
            [moveSequence addObject:@[currentTile, correctTile]];
            
            self.board[posOfCorrect] = currentTile;
            self.board[i] = correctTile;
        }
    }
    
    self.blankPos = 15;
    self.lastBlankPos = -1;
    
    return moveSequence;
}


#pragma mark - Board shuffle methods


// Makes random moves equal to the parameter times
// Returns: An array of arrays that each contain two buttons that were swapped
-(NSArray*)shuffleBoard:(int)times
{
    NSMutableArray *moveSequence = [NSMutableArray array];
    
    for (int i = 0; i < times; ++i) {
        
        int posToMove = [self posOfRandomNonBackwardsNeighborToBlank];
        [self moveBlankToPos:posToMove];
        [moveSequence addObject:@[self.board[self.blankPos], self.board[self.lastBlankPos]]];
    }
    
    return moveSequence;
}

// Returns: index of a legal move that wasn't the previous move
-(int) posOfRandomNonBackwardsNeighborToBlank
{
    NSMutableArray *legalMoves = [NSMutableArray array];
    int move;
    
    // get the positions of each legal move and add to legalMoves array
    if ((move = [self leftMove]) != -1 && move != self.lastBlankPos) [legalMoves addObject:[NSNumber numberWithInt:move]];
    if ((move = [self rightMove]) != -1 && move != self.lastBlankPos) [legalMoves addObject:[NSNumber numberWithInt:move]];
    if ((move = [self upMove]) != -1 && move != self.lastBlankPos) [legalMoves addObject:[NSNumber numberWithInt:move]];
    if ((move = [self downMove]) != -1 && move != self.lastBlankPos) [legalMoves addObject:[NSNumber numberWithInt:move]];
    
    // return a random move from the legal moves
    return [[legalMoves objectAtIndex:arc4random_uniform(legalMoves.count)] integerValue];
}


#pragma mark - Move validation methods


// Returns: index of tile to be swapped with the blank tile or -1 if move is invalid
-(int) leftMove
{
    // invalid move if blank is on leftmost column
    if (self.blankPos % 4 == 3) {
        return -1;
    }
    
    // the piece is one column to the right of blank
    return self.blankPos + 1;
}


// Returns: index of tile to be swapped with the blank tile or -1 if move is invalid
-(int) rightMove
{
    // invalid move if blank is on rightmost column
    if (self.blankPos % 4 == 0) {
        return -1;
    }
    
    // the piece is one column to the left of blank
    return self.blankPos - 1;
}

// Returns: index of tile to be swapped with the blank tile or -1 if move is invalid
-(int) upMove
{
    // invalid move if blank is on bottom row
    if (self.blankPos / 4 == 3) {
        return -1;
    }
    
    // the piece is one row below blank
    return self.blankPos + 4;
}

// Returns: index of tile to be swapped with the blank tile or -1 if move is invalid
-(int) downMove
{
    // invalid move if blank is on top row
    if (self.blankPos / 4 == 0) {
        return -1;
    }
    
    // the piece is one row above blank
    return self.blankPos - 4;
}


#pragma mark - Tile movement methods


// Returns: an array that contains the two buttons to swap, or nil if the move is invalid
-(NSArray *) makeLeftMoveIfValid
{
    int move = [self leftMove];
    
    if (move == -1) {
        return nil;
    }
    
    return [self moveBlankToPos:move];
}


// Returns: an array that contains the two buttons to swap, or nil if the move is invalid
-(NSArray *) makeRightMoveIfValid
{
    int move = [self rightMove];
    
    if (move == -1) {
        return nil;
    }
    
    return [self moveBlankToPos:move];
}


// Returns: an array that contains the two buttons to swap, or nil if the move is invalid
-(NSArray *) makeUpMoveIfValid
{
    int move = [self upMove];
    
    if (move == -1) {
        return nil;
    }
    
    return [self moveBlankToPos:move];
}

// Returns: an array that contains the two buttons to swap, or nil if the move is invalid
-(NSArray *) makeDownMoveIfValid
{
    int move = [self downMove];
    
    if (move == -1) {
        return nil;
    }
    
    return [self moveBlankToPos:move];
}

// Updates the internal state of the board by switching the blank tile and the tile at index i
// Returns: array containing the two tiles that were swapped
-(NSArray *) moveBlankToPos:(int) i
{
    [self.board exchangeObjectAtIndex:self.blankPos withObjectAtIndex:i];
    self.lastBlankPos = self.blankPos;
    self.blankPos = i;
    
    return @[self.board[self.lastBlankPos], self.board[self.blankPos]];

}

@end
