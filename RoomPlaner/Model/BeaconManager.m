//
//  BeaconManager.m
//  RoomPlaner
//
//  Created by Moritz on 03.04.14.
//  Copyright (c) 2014 Hackathon. All rights reserved.
//

#define kRegionIdentifier   @"f7826da6-4fa2-4e98-8024-bc5b71e0893e"

#import "BeaconManager.h"

@interface BeaconManager ()

@property (nonatomic,strong) CLLocationManager *locationManager;
@property (nonatomic,strong) CLBeaconRegion *beaconRegion;

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

- (void)loadRooms {
    
}

#pragma mark -
#pragma mark - CLLocaionManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region {
    
}

- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region {
    
}


- (void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region {
    
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
