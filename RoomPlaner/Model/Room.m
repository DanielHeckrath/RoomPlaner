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

@dynamic name, major, minor, occupied;

+ (NSString *)parseClassName {
    return @"Room";
}

- (NSString *)key {
    return [NSString stringWithFormat:@"%@-%d-%d", self.name, self.major.intValue, self.minor.intValue];
}

@end
