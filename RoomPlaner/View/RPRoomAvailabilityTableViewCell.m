//
// RPRoomAvailabilityTableViewCell
// RoomPlaner 
// 
// Created by Ömer Avci on 03.04.14.
// Copyright (c) 2014 Hackathon. All rights reserved.
//

#import "RPRoomAvailabilityTableViewCell.h"
#import "Room.h"
#import <QuartzCore/QuartzCore.h>

@interface RPRoomAvailabilityTableViewCell ()
@property (nonatomic, strong) UIView *occupiedView;
@property (nonatomic, assign, getter = isOccupied) BOOL occupied;
@end

@implementation RPRoomAvailabilityTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setRoom:(Room *)room {
    _room = room;

    self.textLabel.text = _room.name;
    self.detailTextLabel.text = [_room.major stringValue];
    self.occupied = _room.occupied;
}

- (void)setOccupied:(BOOL)occupied {
    _occupied = occupied;

    UIColor *color;
    if (_occupied) {
        color = UIColorFromHex(0xe74c3c); // red
    } else {
        color = UIColorFromHex(0x2ecc71); // green
    }
    self.occupiedView.backgroundColor = color;
}

#pragma mark -
#pragma mark - Setup

- (void)setup {
    self.occupiedView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    self.occupiedView.layer.cornerRadius = CGRectGetWidth(self.occupiedView.frame)/2;
    self.accessoryView = self.occupiedView;
}

@end