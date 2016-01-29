//
//  SidebarViewController.h
//  cs442project
//
//  Created by Xiaoyang Lu on 3/31/14.
//  Copyright (c) 2014 Xiaoyang Lu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface SidebarViewController : UITableViewController
- (IBAction)logoutButtonPressed:(id)sender;

@property (nonatomic, strong) NSArray *menuItems;
@property (strong)NSString *username;
@end
