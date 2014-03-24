//
//  City.m
//  TableViewDemoPart1
//
//  Created by student on 3/24/14.
//  Copyright (c) 2014 Ali Kooshesh. All rights reserved.
//

#import "City.h"

@interface City ()

@property (nonatomic) NSMutableDictionary *cityAttrs;

@end

@implementation City

-(id) initWithDictionary:(NSDictionary *)dictionary
{
    if ( (self = [super init]) == nil )
        return nil;
    self.cityAttrs = [NSMutableDictionary dictionaryWithDictionary:dictionary];
    return self;
}

- (NSString *) cityName
{
    return [self.cityAttrs objectForKey:@"cityName"];
}

@end
