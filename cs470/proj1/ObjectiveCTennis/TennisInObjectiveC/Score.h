//  Additions made by Zachary Thompson
//  Score.h
//  TennisInObjectiveC
//
//  Created by Ali Kooshesh on 1/22/14.
//  Copyright (c) 2014 Ali Kooshesh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Player.h"

@interface Score : NSObject

@property (nonatomic) Player *player1;
@property (nonatomic) Player *player2;
@property (nonatomic) int player1Score;
@property (nonatomic) int player2Score;
@property (nonatomic) Player *winner;

-(instancetype) initWithFirstPlayer: (Player *) p1 secondPlayer: (Player *) p2;
-(BOOL) areTied;
-(void) addScore: (Player *) p;
-(Player *)getWinner;

-(BOOL) haveAWinner;

@end
