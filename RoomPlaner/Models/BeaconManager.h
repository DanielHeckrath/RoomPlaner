//
//  BeaconManager.h
//  RoomPlaner
//
//  Created by Moritz on 03.04.14.
//  Copyright (c) 2014 Hackathon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BeaconManager : NSObject

// return shared instance of beaconmanager
+ (instancetype)sharedInstance;

// list of rooms
@property (nonatomic,strong) NSArray *rooms;

@end
