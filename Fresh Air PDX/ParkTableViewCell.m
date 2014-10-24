//
//  ParkTableViewCell.m
//  Fresh Air PDX
//
//  Created by Ryan Luce on 10/24/14.
//  Copyright (c) 2014 Ryan Luce. All rights reserved.
//

#import "ParkTableViewCell.h"
#import "Park.h"
@interface ParkTableViewCell()
{
    IBOutlet UILabel *parkNameLabel;
    IBOutlet UILabel *addressLabel;
}
@end

@implementation ParkTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)updateWithPark:(Park *)model
{
    parkNameLabel.text = model.parkName;
    addressLabel.text = model.address;
}

@end
