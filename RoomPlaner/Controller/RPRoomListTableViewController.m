//
//  RPRoomListTableViewController.m
//  RoomPlaner
//
//  Created by Paul Ehrhardt on 03.04.14.
//  Copyright (c) 2014 Hackathon. All rights reserved.
//

#import "RPRoomListTableViewController.h"
#import "BeaconManager.h"

@interface RPRoomListTableViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addButton;
@property (strong, nonatomic) BeaconManager *sharedBeaconManager;
@property (strong, nonatomic) NSArray *roomData;
@end

@implementation RPRoomListTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.sharedBeaconManager = [BeaconManager sharedInstance];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // load rooms
    [self loadRoomData];
}


#pragma mark -
#pragma mark - Data loading

- (void)loadRoomData
{
    // load...
    self.roomData = [self.sharedBeaconManager rooms];
}


#pragma mark -
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.roomData count];
}


#pragma mark -
#pragma mark - Table view data source

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ROOM_CELL" forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}

@end
