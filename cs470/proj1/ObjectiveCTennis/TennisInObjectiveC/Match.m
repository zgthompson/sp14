//  Additions made by Zachary Thompson
//  Match.m
//  TennisInObjectiveC
//
//  Created by student on 2/3/14.
//  Copyright (c) 2014 Ali Kooshesh. All rights reserved.
//

#import "Match.h"
#import "MatchScore.h"
#import "Set.h"

@implementation Match

-(Score *) play:(Player *)player
{
    Score *matchScore = [[MatchScore alloc] initWithFirstPlayer:self.player1 secondPlayer:self.player2];
    int setCount = 0;
    
    while( ! [matchScore haveAWinner]) {
        Player *server = setCount++ % 2 == 0 ? player :[Player otherPlayer:player];
        Set* set = [[Set alloc] initWithFirstPlayer:self.player1 secondPlayer:self.player2];
        [(MatchScore*)matchScore addSetScore:[set play:server]];
        set = nil;
    }
    return matchScore;
}

@end
