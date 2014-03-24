//
//  CitiesDataSource.m
//  TableViewDemoPart1
//
//  Created by student on 3/24/14.
//  Copyright (c) 2014 Ali Kooshesh. All rights reserved.
//

#import "CitiesDataSource.h"
#import "City.h"

@interface CitiesDataSource ()

@property (nonatomic) NSMutableArray *allCities;

@end

@implementation CitiesDataSource

-(instancetype) initWithJSONArray:(NSArray *)jsonArray
{
    if ( (self = [super init]) == nil )
        return nil;
    
    _allCities = [[NSMutableArray alloc] init];
    for ( NSDictionary *cityTuple in jsonArray) {
        City *city = [[City alloc] initWithDictionary:cityTuple];
        [self.allCities addObject:city];
    }
    
    return self;
}

-(NSArray *) getAllCities
{
    return self.allCities;
}



@end
