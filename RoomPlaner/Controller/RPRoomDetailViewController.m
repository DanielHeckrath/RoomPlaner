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
    self.labelMajor.text = [NSString stringWithFormat:@"Major value:\t\t %@", [self.room.major stringValue]];
    self.labelMinor.text = [NSString stringWithFormat:@"Minor value:\t\t %@", [self.room.minor stringValue]];
    self.labelOccupation.text = [NSString stringWithFormat:@"Occupied:\t\t %@", self.room.occupied ?  @"YES" : @"NO"];
    
    self.occupationView.clipsToBounds = YES;
    self.occupationView.layer.cornerRadius = self.occupationView.frame.size.width / 2;
    
    UIColor *color;
    if (self.room.occupied) {
        color = UIColorFromHex(0xe74c3c); // red
    } else {
        color = UIColorFromHex(0x2ecc71); // green
    }
    self.occupationView.backgroundColor = color;
}

@end
