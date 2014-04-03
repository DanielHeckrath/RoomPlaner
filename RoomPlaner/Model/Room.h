//
//  Room.h
//  RoomPlaner
//
//  Created by Daniel Heckrath on 03.04.14.
//  Copyright (c) 2014 Hackathon. All rights reserved.
//

#import <Parse/Parse.h>

@interface Room : PFObject <PFSubclassing>

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSNumber *major;
@property (nonatomic, strong) NSNumber *minor;

@end
