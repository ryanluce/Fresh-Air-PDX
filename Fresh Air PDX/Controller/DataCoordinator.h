//
//  DataCoordinator.h
//  Fresh Air PDX
//
//  Created by Ryan Luce on 10/22/14.
//  Copyright (c) 2014 Ryan Luce. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DataCoordinator : NSObject

+ (instancetype)sharedDataCoordinator;

@property (nonatomic, strong) NSMutableArray *loadedParks;
@property (nonatomic, strong) NSMutableArray *loadedParksNearUser;

- (void)loadDataWithBlock:(void (^)(NSMutableArray *loadedData))dataLoaded;
- (void)loadDataNearLatitude:(CGFloat)latitude Longitude:(CGFloat)longitude withBlock:(void (^)(NSMutableArray *loadedData))dataLoaded;;


@end
