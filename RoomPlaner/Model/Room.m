//
//  Room.m
//  RoomPlaner
//
//  Created by Daniel Heckrath on 03.04.14.
//  Copyright (c) 2014 Hackathon. All rights reserved.
//

#import "Room.h"
#import <Parse/PFObject+Subclass.h>

@implementation Room

@dynamic name, major, minor, isOccupied;

+ (NSString *)parseClassName {
    return @"Room";
}

@end
