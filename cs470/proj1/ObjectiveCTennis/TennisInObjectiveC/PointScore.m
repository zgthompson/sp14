//  Additions made by Zachary Thompson
//  PointScore.m
//  TennisInObjectiveC
//
//  Created by Ali Kooshesh on 1/22/14.
//  Copyright (c) 2014 Ali Kooshesh. All rights reserved.
//

#import "PointScore.h"

@implementation PointScore

-(BOOL) haveAWinner
{
    return self.player1Score == 1 || self.player2Score == 1;
}

-(NSString *) description
{
    NSLog(@"PointScore... printing begins.");
    NSLog(@"p1 score = %d", self.player1Score);
    NSLog(@"p2 score = %d", self.player2Score);
    NSLog(@"PointScore... printing ends.");

    return [NSString stringWithFormat:@"\n\nplayer1 score = %d\nplayer2 score = %d\n\n", self.player1Score, self.player2Score ];

}

@end
