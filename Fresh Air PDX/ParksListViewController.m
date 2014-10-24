//
//  ParksListViewController.m
//  Fresh Air PDX
//
//  Created by Ryan Luce on 10/23/14.
//  Copyright (c) 2014 Ryan Luce. All rights reserved.
//

#import "ParksListViewController.h"
#import "DataCoordinator.h"
#import "LocationManager.h"
#import "Park.h"
#import "ParkTableViewCell.h"
#import "ParkDetailViewController.h"
#import <CoreLocation/CoreLocation.h>
#define kParkCellIdentifier @"parkCell"

@interface ParksListViewController () <UITableViewDataSource, UITableViewDelegate, LocationManagerDelegate>
{
    IBOutlet UITableView *parksListTableView;
    DataCoordinator *_dataCoordinator;
    LocationManager *_locationManager;
}
@end

@implementation ParksListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataCoordinator = [DataCoordinator sharedDataCoordinator];
    [_dataCoordinator loadDataWithBlock:^(NSMutableArray *loadedData) {
        [parksListTableView reloadData];
    }];
    _locationManager = [LocationManager sharedLocationManager];
    _locationManager.delegate = self;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TAbleview delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //use local data if we have it loaded
    if(_dataCoordinator.loadedParksNearUser.count)
    {
        return _dataCoordinator.loadedParksNearUser.count;
    }
    
    return _dataCoordinator.loadedParks.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ParkTableViewCell *parkTableViewCell = [tableView dequeueReusableCellWithIdentifier:kParkCellIdentifier];
    Park *parkToUpdateCellWith;
    if(_dataCoordinator.loadedParksNearUser.count)
    {
        parkToUpdateCellWith = _dataCoordinator.loadedParksNearUser[indexPath.row];
    } else
    {
        parkToUpdateCellWith = _dataCoordinator.loadedParks[indexPath.row];
    }
    [parkTableViewCell updateWithPark:parkToUpdateCellWith];
    return parkTableViewCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark - LocationManagerDelegate
- (void)locationManager:(LocationManager *)locationManager didupdateLocation:(CLLocationCoordinate2D)newLocation
{
    [_dataCoordinator loadDataNearLatitude:newLocation.latitude
                                 Longitude:newLocation.longitude
                                 withBlock:^(NSMutableArray *loadedData) {
                                     [parksListTableView reloadData];
                                 }];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    ParkDetailViewController *parkDetailViewController = [segue destinationViewController];
    ParkTableViewCell *cell = sender;
    NSIndexPath *selectedIndexPath = [parksListTableView indexPathForCell:cell];
    Park *parkToShowDetail;
    if(_dataCoordinator.loadedParksNearUser.count)
    {
        parkToShowDetail = _dataCoordinator.loadedParksNearUser[selectedIndexPath.row];
    } else
    {
        parkToShowDetail = _dataCoordinator.loadedParks[selectedIndexPath.row];
    }
    [parkDetailViewController updateWithPark:parkToShowDetail];
    
}


@end
