//
//  BeaconManager.h
//  RoomPlaner
//
//  Created by Moritz on 03.04.14.
//  Copyright (c) 2014 Hackathon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface BeaconManager : NSObject <CLLocationManagerDelegate>

@property (nonatomic,strong) NSArray *rooms;

+ (instancetype)sharedInstance;

- (void)loadRooms;

@end
