//  Additions made by Zachary Thompson
//  TieBreaker.m
//  TennisInObjectiveC
//
//  Created by student on 2/3/14.
//  Copyright (c) 2014 Ali Kooshesh. All rights reserved.
//

#import "TieBreaker.h"
#import "TieBreakerScore.h"

@implementation TieBreaker

-(Score *) play:(Player *)player
{
    Score *score = [[TieBreakerScore alloc] initWithFirstPlayer:self.player1 secondPlayer:self.player2];
    int serveCount = 0;
    Player* server = player;
    
    while ( ! [score haveAWinner]) {
        Score *pScore = [server serveAPoint];
        [score addScore:[pScore getWinner]];
        pScore = nil;
        server = serveCount++ % 4 < 2 ? [Player otherPlayer:player]: player;
    }
    return score;
}

@end
