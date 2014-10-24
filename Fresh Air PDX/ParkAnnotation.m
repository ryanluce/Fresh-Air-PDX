//
//  ParkAnnotation.m
//  Fresh Air PDX
//
//  Created by Ryan Luce on 10/24/14.
//  Copyright (c) 2014 Ryan Luce. All rights reserved.
//

#import "ParkAnnotation.h"

@implementation ParkAnnotation

- (id)initWithTitle:(NSString *)title subtitle:(NSString *)subtitle andCoordinate:(CLLocationCoordinate2D)coordinate
{
    self = [super init];
    if(self)
    {
        _title = title;
        _subtitle = subtitle;
        _coordinate  = coordinate;
    }
    return self;
}

@end
