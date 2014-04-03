//
//  BeaconManager.m
//  RoomPlaner
//
//  Created by Moritz on 03.04.14.
//  Copyright (c) 2014 Hackathon. All rights reserved.
//

#define kRegionIdentifier   @"f7826da6-4fa2-4e98-8024-bc5b71e0893e"

#import "BeaconManager.h"
#import "Room.h"

@interface BeaconManager ()

@property (nonatomic,strong) CLLocationManager *locationManager;
@property (nonatomic,strong) CLBeaconRegion *beaconRegion;
@property (nonatomic,strong) NSMutableArray *beaconsInRange;

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
    }
    
    NSUUID *uuid = [[NSUUID alloc]initWithUUIDString:@"f7826da6-4fa2-4e98-8024-bc5b71e0893e"];
    _beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuid identifier:kRegionIdentifier];
    [_locationManager startMonitoringForRegion:_beaconRegion];
    
    return self;
}

#pragma mark -
#pragma mark - Backend

- (void)loadRooms:(void (^)(BOOL))completion {
    PFQuery *query = [Room query];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        _rooms = objects;
        
        if(completion) {
            completion(YES);
        }
    }];
}

#pragma mark -
#pragma mark - CLLocaionManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region {
    
}

- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region {
    
}


- (void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region {
    for(CLBeacon *beacon in beacons) {
        if(beacon.proximity == CLProximityNear) {
            if([_beaconsInRange indexOfObject:beacon] != NSNotFound) {
                // check if beacon is for our rooms
                for(Room *room in _rooms) {
                    if(room.major == beacon.major && room.minor == beacon.minor) {
                        // good beacon for us
                        [_beaconsInRange addObject:beacon];
                        NSLog(@"set room: %@ to occupied",room.name);
                        room.occupied = YES;
                        
                        [room saveInBackground];
                    }
                }
            }
        } else {
            // check if becon is important for us
            if([_beaconsInRange indexOfObject:beacon] != NSNotFound) {
                // remove beacon
                [_beaconsInRange removeObject:beacon];
                // set room to "free"
                for(Room *room in _rooms) {
                    if(room.minor == beacon.minor && room.major == beacon.major) {
                        NSLog(@"set room: %@ to free",room.name);
                        room.occupied = NO;
                        [room saveInBackground];
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
