//
//  RPRoomDetailViewController.m
//  RoomPlaner
//
//  Created by Paul Ehrhardt on 03.04.14.
//  Copyright (c) 2014 Hackathon. All rights reserved.
//

#import "RPRoomDetailViewController.h"
#import "Room.h"

@interface RPRoomDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *labelRoomName;
@property (weak, nonatomic) IBOutlet UILabel *labelMajor;
@property (weak, nonatomic) IBOutlet UILabel *labelMinor;
@property (weak, nonatomic) IBOutlet UILabel *labelOccupation;

@end

@implementation RPRoomDetailViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Room Detail";
    
    [self populateRoomLabels];
}

- (void)populateRoomLabels
{
    if (!self.room) {
        return;
    }
    
    self.labelRoomName.text = self.room.name;
    self.labelMajor.text = [self.room.major stringValue];
    self.labelMinor.text = [self.room.minor stringValue];
    self.labelOccupation.text = [NSString stringWithFormat:@"Occupied: %@", self.room.occupied ?  @"YES" : @"NO"];
}

@end
