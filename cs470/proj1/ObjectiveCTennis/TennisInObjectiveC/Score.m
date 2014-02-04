//  Additions made by Zachary Thompson
//  Score.m
//  TennisInObjectiveC
//
//  Created by Ali Kooshesh on 1/22/14.
//  Copyright (c) 2014 Ali Kooshesh. All rights reserved.
//

#import "Score.h"

@implementation Score

-(instancetype) initWithFirstPlayer: (Player *) p1 secondPlayer: (Player *) p2;
{
    if( (self = [super init]) == nil )
        return nil;
    
    _player1 = p1;
    _player2 = p2;
    return self;
}


-(Player *)getWinner
{
    return self.player1Score > self.player2Score ? self.player1 : self.player2;
}

-(BOOL) areTied
{
    return self.player1Score == self.player2Score;
}

-(void) addScore: (Player *) p
{
    p == self.player1 ? self.player1Score++ : self.player2Score++;
}

-(BOOL) haveAWinner
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}

-(NSString *) description
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}




@end
