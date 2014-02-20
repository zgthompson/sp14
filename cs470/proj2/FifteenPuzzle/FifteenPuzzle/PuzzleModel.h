//
//  PuzzleModel.h
//  FifteenPuzzle
//
//  Created by student on 2/15/14.
//  Copyright (c) 2014 zgt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PuzzleModel : NSObject

-(id)initWithBoard:(NSArray *)board;

-(BOOL)isSolved;

-(NSArray *)resetBoard;
-(NSArray *)shuffleBoard:(int) times;

-(NSArray *)makeLeftMoveIfValid;
-(NSArray *)makeRightMoveIfValid;
-(NSArray *)makeUpMoveIfValid;
-(NSArray *)makeDownMoveIfValid;

@end
