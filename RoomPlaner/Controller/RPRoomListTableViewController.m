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
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@end

@implementation RPRoomListTableViewController

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.sharedBeaconManager = [BeaconManager sharedInstance];
    
    self.tableView.allowsSelection = NO;
    [self.tableView registerClass:[RPRoomAvailabilityTableViewCell class] forCellReuseIdentifier:CELL_IDENTIFIER];

    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refreshControlPulled:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
    
    [self loadRoomData];
}


- (void)refreshControlPulled:(UIRefreshControl *)sender {
    [self loadRoomData];
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
    __weak typeof(self) weakSelf = self;
    [self.sharedBeaconManager loadRooms:^(BOOL finished) {
        [weakSelf.refreshControl endRefreshing];
        if (finished) {
            weakSelf.rooms = [self.sharedBeaconManager rooms];
            [weakSelf.tableView reloadData];
        } else {
            NSLog(@"ERROR loading room data!");
        }
    }];
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

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end