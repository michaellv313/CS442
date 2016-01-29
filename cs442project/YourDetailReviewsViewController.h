//
//  YourDetailReviewsViewController.h
//  cs442project
//
//  Created by Xiaoyang Lu on 4/1/14.
//  Copyright (c) 2014 Xiaoyang Lu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface YourDetailReviewsViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (strong,nonatomic)NSDate *date;
@property (nonatomic, strong) NSArray *menuItems;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic)NSManagedObjectContext *context;

@end
