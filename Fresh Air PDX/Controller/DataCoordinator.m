//
//  DataCoordinator.m
//  Fresh Air PDX
//
//  Created by Ryan Luce on 10/22/14.
//  Copyright (c) 2014 Ryan Luce. All rights reserved.
//

#import "DataCoordinator.h"
#import "Park.h"
#import <CoreLocation/CoreLocation.h>
//url to call
#define kApiURL @"http://api.civicapps.org/parks/"
//key in the json data that has the array of results returned from the query
#define kApiResultsKey @"results"

#define kApiParkNameKey @"Property"
#define kApiParkAddressKey @"Address"
#define kApiLocationKey @"loc"
#define kApiLocationLatitudeKey @"lat"
#define kApiLocationLongitudeKey @"lon"

#define kApiAmenitiesKey @"amenities"

@implementation DataCoordinator

+ (instancetype)sharedDataCoordinator
{
    static DataCoordinator *sharedDataCoordinator;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedDataCoordinator = [[self alloc] init];
    });
    return sharedDataCoordinator;
}

- (NSString *)apiURL
{
    return @"http://api.civicapps.org/parks/count=30";
}

- (NSString *)apiURLNearLatitude:(CGFloat)latitude andLongitude:(CGFloat)longitude
{
    return [NSString stringWithFormat:@"http://api.civicapps.org/parks/near/%f,%f?count=30", longitude, latitude];
}

- (void)loadDataWithBlock:(void (^)(NSMutableArray *))dataLoaded
{
   //TODO switch to NSOperation
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH,  0);
    dispatch_async(queue, ^{
        NSURL *jsonDataURL = [NSURL URLWithString:[self addCountToURL:kApiURL]];
        NSData *jsonData = [NSData dataWithContentsOfURL:jsonDataURL];
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self parseData:jsonData isLocal:NO];
            dataLoaded(self.loadedParks);
        });
    });
}

- (void)loadDataNearLatitude:(CGFloat)latitude Longitude:(CGFloat)longitude withBlock:(void (^)(NSMutableArray *))dataLoaded
{
    //TODO switch to NSOperation
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH,  0);
    dispatch_async(queue, ^{
        NSString *apiCallWithLocation = [NSString stringWithFormat:@"%@near/%f,%f", kApiURL, longitude, latitude];
        NSURL *jsonDataURL = [NSURL URLWithString:[self addCountToURL:apiCallWithLocation]];
        NSData *jsonData = [NSData dataWithContentsOfURL:jsonDataURL];
        dispatch_sync(dispatch_get_main_queue(), ^{
            //if no data was returned, can't show anything
            if(!jsonData) return;
            [self parseData:jsonData isLocal:YES];
            dataLoaded(self.loadedParks);
        });
    });
}

 
- (void)parseData:(NSData *)jsonData isLocal:(BOOL)isLocal
{
    NSError *error;
    NSDictionary *resultsDictionary = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                      options:NSJSONReadingAllowFragments
                                                                        error:&error];
    NSArray *resultsArray = resultsDictionary[kApiResultsKey];
    if(isLocal)
    {
        self.loadedParksNearUser = [NSMutableArray arrayWithCapacity:resultsArray.count];
    } else
    {
        self.loadedParks = [NSMutableArray arrayWithCapacity:resultsArray.count];
    }
    for(NSDictionary *parkDictionary in resultsArray)
    {
        Park *temporaryPark = [[Park alloc] init];
        temporaryPark.parkName = parkDictionary[kApiParkNameKey];
        NSArray *temporaryAmenities = parkDictionary[kApiAmenitiesKey];
        temporaryPark.amenities = [temporaryAmenities componentsJoinedByString:@", "];
        NSDictionary *temporaryLocation = parkDictionary[kApiLocationKey];
        temporaryPark.location = CLLocationCoordinate2DMake([temporaryLocation[kApiLocationLatitudeKey] floatValue],
                                                            [temporaryLocation[kApiLocationLongitudeKey] floatValue]);
        temporaryPark.address = parkDictionary[kApiParkAddressKey];
        if(isLocal)
        {
            [self.loadedParksNearUser addObject:temporaryPark];
        } else
        {
            [self.loadedParks addObject:temporaryPark];
        }
        
    }
    
}

- (NSString *)addCountToURL:(NSString *)URLString
{
    return [NSString stringWithFormat:@"%@?count=20", URLString];
}


@end
