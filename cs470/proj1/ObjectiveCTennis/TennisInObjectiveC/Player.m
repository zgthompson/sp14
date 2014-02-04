//  Additions made by Zachary Thompson
//  Player.m
//  TennisInObjectiveC
//
//  Created by Ali Kooshesh on 1/22/14.
//  Copyright (c) 2014 Ali Kooshesh. All rights reserved.
//
//  Changes made by Zachary Thompson

#import "Player.h"
#import "PointScore.h"
#import <Foundation/Foundation.h>


@interface Player()

@property (nonatomic) int myPlayerIdx;

-(int) getARandomNumber;

@end

static int playersIdx = 0;
static Player *players[2];
int MAX_PLAYERS = 2;
BOOL debug = YES;

@implementation Player

-(instancetype) initWithProbability:(int) prob
{
    if( (self = [super init]) == nil )
        return nil;
    [self setProbabilityOfWinningAServe: prob];
    /*
    if( debug )
        NSLog(@"%@: prob is %d", self.class, [self probabilityOfWinningAServe]);
     */
    if( playersIdx > MAX_PLAYERS ) {
        NSLog(@"%@::%@ Already have created two players. No more.", self.class, NSStringFromSelector(_cmd));
        exit(1); // not very tactful! But, what else can you do?
    }
    self.myPlayerIdx = playersIdx;
    players[playersIdx++] = self;
    return self;
}

-(Score *) serveAPoint
{
    if( playersIdx != MAX_PLAYERS ) {
        NSLog(@"%@::%@ You need two players to play this game.", self.class, NSStringFromSelector(_cmd));
        exit(1);
    }
    int rand = [self getARandomNumber];
    /*
    if( debug )
        NSLog(@"Generated random-number %d", rand);
     */
    Score *score = [[PointScore alloc] initWithFirstPlayer:players[0] secondPlayer:players[1]];
    [score addScore: rand <= self.probabilityOfWinningAServe ? self : [Player otherPlayer:self]];
    return score;
}

+(Player *) otherPlayer:(Player *)player
{
    return players[(player.myPlayerIdx + 1) % 2];
}

-(int) getARandomNumber
{
    return random() % 100 + 1;
}

@end
