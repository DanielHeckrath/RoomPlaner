//
//  BeaconManager.m
//  RoomPlaner
//
//  Created by Moritz on 03.04.14.
//  Copyright (c) 2014 Hackathon. All rights reserved.
//

#import "BeaconManager.h"

@implementation BeaconManager

+ (instancetype)sharedInstance {
    
    static BeaconManager *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [BeaconManager new];
    });
    
    return sharedInstance;
}
@end
