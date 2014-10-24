//
//  LocationManager.m
//  Fresh Air PDX
//
//  Created by Ryan Luce on 10/24/14.
//  Copyright (c) 2014 Ryan Luce. All rights reserved.
//

#import "LocationManager.h"

@interface LocationManager() <CLLocationManagerDelegate>
{
    CLLocationManager *_locationManager;
}
@end

@implementation LocationManager

+ (instancetype)sharedLocationManager
{
    static LocationManager *sharedLocationManager;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedLocationManager = [[self alloc] init];
    });
    return sharedLocationManager;
}

- (id)init
{
    self = [super init];
    if(self)
    {
        [self setupLocationManager];
    }
    return self;
}

- (void)setupLocationManager
{
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    if ([_locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [_locationManager requestWhenInUseAuthorization];
    }
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    //update every km of change
    _locationManager.distanceFilter = 1000;
    [_locationManager startUpdatingLocation];
    
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *newLocation = [locations lastObject];
    if(self.delegate)
    {
        [self.delegate locationManager:self
                     didupdateLocation:newLocation.coordinate];
    }
}

@end
