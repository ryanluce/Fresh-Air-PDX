//
//  ParkDetailViewController.m
//  Fresh Air PDX
//
//  Created by Ryan Luce on 10/24/14.
//  Copyright (c) 2014 Ryan Luce. All rights reserved.
//

#import "ParkDetailViewController.h"
#import "Park.h"
#import "ParkAnnotation.h"
#import <MapKit/MapKit.h>

@interface ParkDetailViewController ()
{
    IBOutlet UILabel *amenitiesLabel;
    IBOutlet MKMapView *mapView;
    Park *park;
}
@end

@implementation ParkDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = park.parkName;
    
    //Setup the label and size it to fit it's contents
    amenitiesLabel.text = park.amenities;
    [amenitiesLabel sizeToFit];
    
    [mapView setShowsUserLocation:YES];
    
    //zoom in on the park
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(park.location, 500, 500);
    MKCoordinateRegion adjustedRegion = [mapView regionThatFits:viewRegion];
    [mapView setRegion:adjustedRegion animated:NO];
    
    //Add annotation to show user where the park is
    ParkAnnotation *annotationToAdd = [[ParkAnnotation alloc] initWithTitle:park.parkName
                                                                   subtitle:park.address
                                                              andCoordinate:park.location];
    [mapView addAnnotation:annotationToAdd];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateWithPark:(Park *)model
{
    park = model;
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
