//
//  ParkTableViewCell.h
//  Fresh Air PDX
//
//  Created by Ryan Luce on 10/24/14.
//  Copyright (c) 2014 Ryan Luce. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Park;

@interface ParkTableViewCell : UITableViewCell

- (void)updateWithPark:(Park *)model;
@end
