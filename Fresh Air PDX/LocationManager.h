//
//  LocationManager.h
//  Fresh Air PDX
//
//  Created by Ryan Luce on 10/24/14.
//  Copyright (c) 2014 Ryan Luce. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
@protocol LocationManagerDelegate;

@interface LocationManager : NSObject

+ (instancetype)sharedLocationManager;

@property (nonatomic, weak) id<LocationManagerDelegate>delegate;


@end

@protocol LocationManagerDelegate
- (void)locationManager:(LocationManager *)locationManager didupdateLocation:(CLLocationCoordinate2D)newLocation;
@end