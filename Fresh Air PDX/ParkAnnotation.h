//
//  ParkAnnotation.h
//  Fresh Air PDX
//
//  Created by Ryan Luce on 10/24/14.
//  Copyright (c) 2014 Ryan Luce. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ParkAnnotation : NSObject <MKAnnotation>

- (id)initWithTitle:(NSString *)title subtitle:(NSString *)subtitle andCoordinate:(CLLocationCoordinate2D)coordinate;

@property (nonatomic, readonly, copy) NSString *title;
@property (nonatomic, readonly, copy) NSString *subtitle;
@property(nonatomic, readonly) CLLocationCoordinate2D coordinate;
@end
