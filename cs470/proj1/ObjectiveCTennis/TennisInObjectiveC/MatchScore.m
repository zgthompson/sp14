//  Additions made by Zachary Thompson
//  MatchScore.m
//  TennisInObjectiveC
//
//  Created by student on 2/3/14.
//  Copyright (c) 2014 Ali Kooshesh. All rights reserved.
//

#import "MatchScore.h"

@interface MatchScore ()

@property (nonatomic) NSMutableArray *scores;

@end

@implementation MatchScore

-(id) initWithFirstPlayer:(Player *)p1 secondPlayer:(Player *)p2
{
    if( (self = [super initWithFirstPlayer:p1 secondPlayer:p2   ]) == nil)
        return nil;
    self.scores = [NSMutableArray array];
    return self;
}

-(BOOL) haveAWinner
{
    return self.player1Score == 3 || self.player2Score == 3;
}

-(void) addSetScore:(Score *)score
{
    [self addScore:[score getWinner]];
    [self.scores addObject:score];
}

-(NSString *) description
{
    NSMutableString *result = [NSMutableString stringWithString:@"\n   Set No.    Player A          Player B\n"];
    
    int setCount = 1;
    for (Score* score in self.scores) {
        [result appendFormat:@"%7d%@\n", setCount++, score];
    }
    
    char winner;
    int winScore, loseScore;
    
    if (self.player1Score > self.player2Score) {
        winner = 'A';
        winScore = self.player1Score;
        loseScore = self.player2Score;
    }
    else {
        winner = 'B';
        winScore = self.player2Score;
        loseScore = self.player1Score;
    }
    
    [result appendFormat:@"\nPlayer %c wins the match %d sets to %d\n", winner, winScore, loseScore];
    
    return result;
}

@end
