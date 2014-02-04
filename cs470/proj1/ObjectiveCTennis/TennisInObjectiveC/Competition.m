//  Additions made by Zachary Thompson
//  Competition.m
//  TennisInObjectiveC
//
//  Created by Ali Kooshesh on 1/22/14.
//  Copyright (c) 2014 Ali Kooshesh. All rights reserved.
//

#import "Competition.h"

@interface Competition()

@end

@implementation Competition

-(instancetype) initWithFirstPlayer: (Player *) p1 secondPlayer: (Player *) p2
{
    if( (self = [super init]) == nil )
        return nil;
    self.player1 = p1;
    self.player2 = p2;
    return self;
}

-(Score *) play: (Player *) player
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}

@end
