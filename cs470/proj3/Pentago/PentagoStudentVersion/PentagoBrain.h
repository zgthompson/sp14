//
//  PentagoBrain.h
//  PentagoStudentVersion
//
// Zachary Thompson
//

#import <Foundation/Foundation.h>

@interface PentagoBrain : NSObject

+(PentagoBrain *) sharedInstance;
-(BOOL) isPlayer1Turn;
-(BOOL) makeMoveIfValidOnBoard:(int) board atRow:(int) row andCol:(int) col;
-(BOOL) makeRotationIfValidOnBoard:(int) board inDirection:(int) direction;

@end
