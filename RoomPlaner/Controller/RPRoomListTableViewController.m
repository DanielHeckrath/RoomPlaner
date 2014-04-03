//
//  RPRoomListTableViewController.m
//  RoomPlaner
//
//  Created by Paul Ehrhardt on 03.04.14.
//  Copyright (c) 2014 Hackathon. All rights reserved.
//

#import "RPRoomListTableViewController.h"
#import "BeaconManager.h"
#import "RPRoomAvailabilityTableViewCell.h"
#import "Room.h"

static NSString * const CELL_IDENTIFIER = @"RPRoomTableViewCell";

@interface RPRoomListTableViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addButton;
@property (strong, nonatomic) BeaconManager *sharedBeaconManager;
@property (nonatomic, strong) NSArray *rooms;
@end

@implementation RPRoomListTableViewController

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        self.sharedBeaconManager = [BeaconManager sharedInstance];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.allowsSelection = NO;
    [self.tableView registerClass:[RPRoomAvailabilityTableViewCell class] forCellReuseIdentifier:CELL_IDENTIFIER];

    self.rooms = [self mockedRooms];
}

- (NSArray *)mockedRooms {
    Room *firstRoom = [[Room alloc] init];
    firstRoom.name = @"Startplatz 01";
    firstRoom.occupied = YES;
    Room *secondRoom = [[Room alloc] init];
    secondRoom.name = @"Startplatz 02";
    secondRoom.occupied = NO;
    Room *thirdRoom = [[Room alloc] init];
    thirdRoom.name = @"Startplatz 03";
    thirdRoom.occupied = YES;
    return @[firstRoom, secondRoom, thirdRoom];
}

#pragma mark -
#pragma mark - Data loading

- (void)loadRoomData {
    // load...
    self.rooms = [self.sharedBeaconManager rooms];
}

#pragma mark -
#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

#pragma mark -
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.rooms count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RPRoomAvailabilityTableViewCell *roomTableViewCell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER];
    roomTableViewCell.room = self.rooms[(NSUInteger) indexPath.row];
    return roomTableViewCell;
}

@end