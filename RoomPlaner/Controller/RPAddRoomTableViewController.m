//
//  RPAddRoomTableViewController.m
//  RoomPlaner
//
//  Created by Daniel Heckrath on 03.04.14.
//  Copyright (c) 2014 Hackathon. All rights reserved.
//

#import "RPAddRoomTableViewController.h"
#import "Room.h"

@interface RPAddRoomTableViewController ()

@property (nonatomic, strong) IBOutlet UITextField *nameTextField;
@property (nonatomic, strong) IBOutlet UITextField *majorTextField;
@property (nonatomic, strong) IBOutlet UITextField *minorTextField;

@end

@implementation RPAddRoomTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Add Room";
    
    self.tableView.tableFooterView = [[UIView alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction)cancel:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)addRoom:(id)sender {
    if (self.nameTextField.text.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Raumname nicht angegeben" message:@"Bitte gib einen Raumnamen an" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    if (self.majorTextField.text.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Raumname nicht angegeben" message:@"Bitte gib einen Raumnamen an" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    if (self.minorTextField.text.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Raumname nicht angegeben" message:@"Bitte gib einen Raumnamen an" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    Room *room = [[Room alloc] init];
    room.name = self.nameTextField.text;
    room.major = [NSNumber numberWithInt:self.majorTextField.text.intValue];
    room.minor = [NSNumber numberWithInt:self.minorTextField.text.intValue];
    room.occupied = NO;
    
    PFQuery *query = [Room query];
    [query whereKey:@"major" equalTo:room.major];
    [query whereKey:@"minor" equalTo:room.minor];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (objects.count == 0) {
            [room saveInBackgroundWithBlock:^(BOOL succeded, NSError *error) {
                if (error != nil) {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Fehler" message:@"Beim speichern ist ein Fehler aufgetreten" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                    [alert show];
                } else if (succeded) {
                    [self.navigationController popViewControllerAnimated:YES];
                }
            }];
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Fehler" message:@"Es existiert bereits ein Raum mit dieser Major/Minor Number Kombination." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
        }
    }];
    
}

@end
