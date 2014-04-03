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
@property (weak, nonatomic) IBOutlet UIView *occupationView;

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
    self.labelMajor.text = [NSString stringWithFormat:@"Major value: %@", [self.room.major stringValue]];
    self.labelMinor.text = [NSString stringWithFormat:@"Minor value: %@", [self.room.minor stringValue]];
    self.labelOccupation.text = [NSString stringWithFormat:@"Occupied: %@", self.room.occupied ?  @"YES" : @"NO"];
    
    self.occupationView.clipsToBounds = YES;
    self.occupationView.layer.cornerRadius = self.occupationView.frame.size.width / 2;
    self.occupationView.backgroundColor = self.room.occupied ? [UIColor redColor] : [UIColor greenColor];
}

@end
