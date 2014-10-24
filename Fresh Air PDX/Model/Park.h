//
//  Park.h
//  Fresh Air PDX
//
//  Created by Ryan Luce on 10/22/14.
//  Copyright (c) 2014 Ryan Luce. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface Park : NSObject

@property (nonatomic, strong) NSString *parkName;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, readwrite) CLLocationCoordinate2D location;
@property (nonatomic, strong) NSString *amenities;

@end
