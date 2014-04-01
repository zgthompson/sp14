//  Zachary Thompson

//  CitiesDataSource.h
//  TableViewDemoPart1
//
//  Created by student on 3/24/14.
//  Copyright (c) 2014 Ali Kooshesh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "City.h"

@interface CitiesDataSource : NSObject

@property (nonatomic) BOOL dataReadyForUse;

-(instancetype) initWithJSONArray:(NSArray *) jsonArray;
-(NSArray *) getAllCities;
-(int) numberOfCities;
-(City *) cityAtIndex:(int) index;

@end
