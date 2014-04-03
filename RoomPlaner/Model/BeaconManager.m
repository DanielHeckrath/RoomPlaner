//
//  BeaconManager.m
//  RoomPlaner
//
//  Created by Moritz on 03.04.14.
//  Copyright (c) 2014 Hackathon. All rights reserved.
//

#define kUIDD               @"f7826da6-4fa2-4e98-8024-bc5b71e0893e"
#define kRegionIdentifier   @"f7826da6-4fa2-4e98-8024-bc5b71e0893e"

#import "BeaconManager.h"
#import "Room.h"
#import "NSObject+Blocks.h"

NSString * const kRPDidUpdateRoomNotification = @"RoomPlaner:DidUpdateRooms";

@interface BeaconManager ()

@property (nonatomic,strong) CLLocationManager *locationManager;
@property (nonatomic,strong) CLBeaconRegion *beaconRegion;
@property (nonatomic,strong) NSMutableArray *beaconsInRange;

@property (nonatomic, strong) NSMutableDictionary *roomBlocks;

@end

@implementation BeaconManager

+ (instancetype)sharedInstance {
    static BeaconManager *sharedManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [BeaconManager new];
    });
    
    return sharedManager;
}

#pragma mark -
#pragma mark - General

- (id)init {
    if(self = [super init]) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        
        NSUUID *uuid = [[NSUUID alloc]initWithUUIDString:kUIDD];
        _beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuid identifier:kRegionIdentifier];
        [_locationManager startMonitoringForRegion:_beaconRegion];
        
        [self loadRooms:nil];
        
        // init array
        _beaconsInRange = [NSMutableArray new];
        _roomBlocks = [NSMutableDictionary new];
    }
    return self;
}

#pragma mark -
#pragma mark - Backend

- (void)loadRooms:(void (^)(BOOL finished))completion {
    PFQuery *query = [Room query];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        _rooms = objects;
        NSLog(@"did load rooms");
        if(completion) {
            completion(YES);
        }
    }];
}

#pragma mark -
#pragma mark - CLLocaionManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region {
    NSLog(@"Did enter readion: %@", region);
}

- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region {
    NSLog(@"Did exit readion: %@", region);
}


- (void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region {
    for(CLBeacon *beacon in beacons) {
        if(beacon.proximity == CLProximityNear || beacon.proximity == CLProximityImmediate) {
            if([_beaconsInRange indexOfObjectPassingTest:^BOOL(CLBeacon *obj, NSUInteger idx, BOOL *stop) {
                return ([obj.minor isEqual:beacon.minor] && [obj.major isEqual:beacon.major]);
            }] == NSNotFound) {
                // check if beacon is for our rooms
                for(Room *room in _rooms) {
                    if([room.major isEqual:beacon.major] && [room.minor isEqual:beacon.minor]) {
                        // good beacon for us
                        [_beaconsInRange addObject:beacon];
                        NSLog(@"set room: %@ to occupied",room.name);
                        room.occupied = YES;
                        
                        [room saveInBackground];
                        
                        id block = self.roomBlocks[[room key]];
                        if (block) {
                            [NSObject cancelBlock:block];
                        }
                        
                        [[NSNotificationCenter defaultCenter] postNotificationName:kRPDidUpdateRoomNotification object:nil userInfo:nil];
                    }
                }
            }
        } else {
            // check if becon is important for us
            NSUInteger index = [_beaconsInRange indexOfObjectPassingTest:^BOOL(CLBeacon *obj, NSUInteger idx, BOOL *stop) {
                return ([obj.minor isEqual:beacon.minor] && [obj.major isEqual:beacon.major]);
            }];
            if(index != NSNotFound) {
                // set room to "free"
                for(Room *room in _rooms) {
                    if([room.major isEqual:beacon.major] && [room.minor isEqual:beacon.minor]) {
                        [_beaconsInRange removeObjectAtIndex:index];
                        NSLog(@"dispatch - set room: %@ to free",room.name);
                        id block = [room performBlock:^{
                            NSLog(@"set room: %@ to free",room.name);
                            room.occupied = NO;
                            [room saveInBackground];
                            [self.roomBlocks removeObjectForKey:[room key]];
                            [[NSNotificationCenter defaultCenter] postNotificationName:kRPDidUpdateRoomNotification object:nil userInfo:nil];
                        } afterDelay:10];
                        
                        self.roomBlocks[[room key]] = block;
                    }
                }
            }
        }
    }
}

- (void)locationManager:(CLLocationManager *)manager rangingBeaconsDidFailForRegion:(CLBeaconRegion *)region withError:(NSError *)error {
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
}

- (void)locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region {
    
    if([region.identifier isEqualToString:kRegionIdentifier]) {
        NSLog(@"start ranging beacons");
        [manager startRangingBeaconsInRegion:_beaconRegion];
    }
}

@end
