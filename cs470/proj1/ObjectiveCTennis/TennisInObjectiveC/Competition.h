//  Additions made by Zachary Thompson
//  Competition.h
//  TennisInObjectiveC
//
//  Created by Ali Kooshesh on 1/22/14.
//  Copyright (c) 2014 Ali Kooshesh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Player.h"

@interface Competition : NSObject

@property (nonatomic) Player *player1;
@property (nonatomic) Player *player2;

-(instancetype) initWithFirstPlayer: (Player *) p1 secondPlayer: (Player *) p2;
-(Score *) play: (Player *) player;

@end
