//
//  PentagoBrain.h
//  PentagoStudentVersion
//
//  Created by AAK on 2/17/14.
//  Copyright (c) 2014 Ali Kooshesh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PentagoBrain : NSObject

+(PentagoBrain *) sharedInstance;
-(BOOL) isPlayer1Turn;
-(BOOL) makeMoveIfValidOnBoard:(int) board atRow:(int) row andCol:(int) col;
-(BOOL) makeRotationIfValidOnBoard:(int) board inDirection:(int) direction;
-(BOOL) hasWinner;

@end
