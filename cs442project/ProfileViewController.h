//
//  ProfileViewController.h
//  cs442project
//
//  Created by Xiaoyang Lu on 4/1/14.
//  Copyright (c) 2014 Xiaoyang Lu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface ProfileViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (nonatomic, strong) NSArray *menuItems;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)editButtonPressed:(id)sender;

@end
