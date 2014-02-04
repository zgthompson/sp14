//  Additions made by Zachary Thompson
//  TieBreakerScore.m
//  TennisInObjectiveC
//
//  Created by student on 2/3/14.
//  Copyright (c) 2014 Ali Kooshesh. All rights reserved.
//

#import "TieBreakerScore.h"

@implementation TieBreakerScore

-(BOOL) haveAWinner
{
    return ( self.player1Score >= 7 || self.player2Score >= 7) && abs(self.player1Score - self.player2Score) >= 2;
}

-(NSString *) description
{
    return [NSString stringWithFormat:@"  (tie breaker %d-%d)", self.player1Score, self.player2Score];
}

@end
