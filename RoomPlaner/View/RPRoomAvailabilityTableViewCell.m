//
// RPRoomAvailabilityTableViewCell
// RoomPlaner 
// 
// Created by Ömer Avci on 03.04.14.
// Copyright (c) 2014 Hackathon. All rights reserved.
//

#import "RPRoomAvailabilityTableViewCell.h"
#import "Room.h"

@interface RPRoomAvailabilityTableViewCell ()
@property (nonatomic, strong) UIView *occupiedView;
@property (nonatomic, assign, getter = isOccupied) BOOL occupied;
@end

@implementation RPRoomAvailabilityTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    return [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
}

- (void)setRoom:(Room *)room {
    _room = room;

    self.textLabel.text = _room.name;
    self.detailTextLabel.text = [_room.major stringValue];
    //self.occupied = _room.isOccupied;
}

@end