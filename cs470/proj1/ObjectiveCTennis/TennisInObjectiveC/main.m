//  Additions made by Zachary Thompson
//  main.m
//  TennisInObjectiveC
//
//  Created by Ali Kooshesh on 1/22/14.
//  Copyright (c) 2014 Ali Kooshesh. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"
#import "Player.h"
#import "Match.h"
#import "MatchScore.h"

int main(int argc, char * argv[])
{
    
    @autoreleasepool {
        int prob1 = 50;
        int prob2= 50;
        int randomSeed = 15;
        NSString* firstLog = [NSString stringWithFormat:@"\n\nThe seed for the random number generator is %d.\nPlayer A has a %d%% chance of winning the serve.\nPlayer B has a %d%% chance of winning the serve.\n", randomSeed, prob1, prob2];
                              
        srandom(randomSeed);
        Player *player1 = [[Player alloc] initWithProbability: prob1];
        Player *player2 = [[Player alloc] initWithProbability: prob2];
        Match  *match = [[Match alloc] initWithFirstPlayer:player1 secondPlayer:player2];
        Score *matchScore = [match play:player1]; // let player1 serve for this game.
        NSLog(@"%@%@", firstLog, matchScore);
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
