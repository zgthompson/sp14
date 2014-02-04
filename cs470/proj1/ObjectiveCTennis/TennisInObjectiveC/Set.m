//    Additions made by Zachary Thompson
//  Set.m
//  TennisInObjectiveC
//
//  Created by student on 2/3/14.
//  Copyright (c) 2014 Ali Kooshesh. All rights reserved.
//

#import "Set.h"
#import "SetScore.h"
#import "Game.h"
#import "TieBreaker.h"

@implementation Set

-(instancetype) initWithFirstPlayer:(Player *)p1 secondPlayer:(Player *)p2
{
    if( (self = [super initWithFirstPlayer:p1 secondPlayer:p2]) == nil)
        return nil;
    return self;
}

-(Score *) play:(Player *)player
{
    Score *setScore = [[SetScore alloc] initWithFirstPlayer:self.player1 secondPlayer:self.player2];
    
    int gameCount = 0;
    
    while( ! [setScore haveAWinner]) {
        Player *server = ++gameCount % 2 == 1 ? player : [Player otherPlayer:player];
        
        if ( [(SetScore*)setScore shouldPlayTieBreaker]) {
            TieBreaker *tb = [[TieBreaker alloc] initWithFirstPlayer:self.player1 secondPlayer:self.player2];
            [(SetScore*)setScore addTieScore:(TieBreakerScore*)[tb play:server]];
            tb = nil;
        
        }
        else {
            Game *game = [[Game alloc] initWithFirstPlayer:self.player1 secondPlayer:self.player2];
            [setScore addScore:[[game play:server] getWinner]];
            game = nil;
        }
    }
    return setScore;
}
@end
