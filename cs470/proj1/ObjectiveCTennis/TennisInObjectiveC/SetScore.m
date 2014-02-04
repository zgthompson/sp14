//  Additions made by Zachary Thompson
//  SetScore.m
//  TennisInObjectiveC
//
//  Created by student on 2/3/14.
//  Copyright (c) 2014 Ali Kooshesh. All rights reserved.
//

#import "SetScore.h"

@interface SetScore ()

@property (nonatomic) TieBreakerScore *tbscore;

@end

@implementation SetScore

-(BOOL) haveAWinner
{
    return ( ((self.player1Score >= 6 || self.player2Score >= 6) && abs( self.player1Score - self.player2Score ) >= 2) || self.tbscore);
}

-(BOOL) shouldPlayTieBreaker
{
    return self.player1Score == 6 && self.player2Score == 6;
}

-(void) addTieScore:(TieBreakerScore *)tbs {
    [self addScore:[tbs winner]];
    self.tbscore = tbs;
}

-(NSString *) description
{
    NSMutableString *result = [NSMutableString stringWithFormat:@"%10d%18d", self.player1Score, self.player2Score];
    
    if (self.tbscore) {
        [result appendString:[self.tbscore description]];
    }
    return result;
}

@end
