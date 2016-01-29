//
//  CurrentStatusViewController.h
//  cs442project
//
//  Created by Xiaoyang Lu on 4/1/14.
//  Copyright (c) 2014 Xiaoyang Lu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface CurrentStatusViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (strong,nonatomic)NSManagedObjectContext *context;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *menuItems;
- (IBAction)cancelButtonPressed:(id)sender;
- (IBAction)arrivedButtonPressed:(id)sender;

@end
