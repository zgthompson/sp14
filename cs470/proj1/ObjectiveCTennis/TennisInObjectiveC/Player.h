//  Additions made by Zachary Thompson
//  Player.h
//  TennisInObjectiveC
//
//  Created by Ali Kooshesh on 1/22/14.
//  Copyright (c) 2014 Ali Kooshesh. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Score;

@interface Player : NSObject

@property (nonatomic) int probabilityOfWinningAServe;

+(Player *) otherPlayer: (Player *) player;

-(instancetype) initWithProbability:(int) prob;
-(Score *) serveAPoint;

@end
