//
//  TheaterDataSource.m
//  TableViewDemoPart1
//
//  Created by AAK on 3/8/14.
//  Copyright (c) 2014 Ali Kooshesh. All rights reserved.
//

#import "TheatersDataSource.h"
#import "Theater.h"

static BOOL _debug = NO;

@interface TheatersDataSource ()

@property(nonatomic) NSMutableArray *allTheaters;
@property (nonatomic) NSMutableDictionary *theatersByCity;

@end

@implementation TheatersDataSource

-(instancetype) initWithJSONArray:(NSArray *)jsonArray
{
    if( (self = [super init]) == nil )
        return nil;
    
    _allTheaters = [[NSMutableArray alloc] init];
    for ( NSDictionary *theaterTuple in jsonArray ) {
        Theater *theater = [[Theater alloc] initWithDictionary:theaterTuple];
        if( _debug) [theater print];
        [self.allTheaters addObject: theater];
    }
    
    _theatersByCity = [[NSMutableDictionary alloc] init];
    for ( Theater *theater in self.allTheaters) {
        NSMutableArray* curArray = [self.theatersByCity objectForKey:theater.cityName];
        if (curArray) {
            [curArray addObject:theater];
        }
        else {
            [self.theatersByCity setObject:[[NSMutableArray alloc] initWithObjects:theater, nil] forKey:theater.cityName];
        }
    }
    
    return self;
}


-(Theater *) theaterWithName: (NSString *) theaterName
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"theaterName = %@", theaterName];
    NSArray *theater = [self.allTheaters filteredArrayUsingPredicate:predicate];
    return [theater count] == 0 ? nil : [theater objectAtIndex: 0];    
}

-(NSArray *) theatersWithCityName:(NSString *) cityName
{
    return [self.theatersByCity valueForKey:cityName];
}

-(int) numberOfTheatersForCity:(NSString *)cityName
{
    return [[self.theatersByCity valueForKey:cityName] count];
}

-(Theater *) theaterAtIndex:(int) index forCity:(NSString *)cityName
{
    return [[self.theatersByCity valueForKey:cityName] objectAtIndex:index];
}

-(NSArray *) getAllTheaters
{
    return self.allTheaters;
}

-(Theater *) theaterAtIndex: (int) idx
{
    return [self.allTheaters objectAtIndex:idx];
}

-(int) numberOfTheaters
{
    return [self.allTheaters count];
}

-(NSString *) theaterTabBarTitle
{
    return @"Theaters";
}
-(NSString *) theaterTabBarImage
{
    return nil;
}
-(NSString *) theaterBarButtonItemBackButtonTitle
{
    return @"Theaters";
}

-(BOOL) deleteTheaterAtIndex: (NSInteger) idx
{
    // Need to preserve the referential integrity of the dataset.
    // Will have to cascade delete moives-at-theaters and showtimes.
    
    return NO;
}

-(void) print
{
    NSLog(@"Printing theaters...");
    for( Theater *theater in self.allTheaters )
        [theater print];
    NSLog(@"Printing theaters ends.");
}


@end
