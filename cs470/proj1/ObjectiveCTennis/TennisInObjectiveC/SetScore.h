//   Additions made by Zachary Thompson
//
//  SetScore.h
//  TennisInObjectiveC
//
//  Created by student on 2/3/14.
//  Copyright (c) 2014 Ali Kooshesh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Score.h"
#import "TieBreakerScore.h"

@interface SetScore : Score

-(BOOL) shouldPlayTieBreaker;
-(void) addTieScore: (TieBreakerScore*) tbs;

@end
