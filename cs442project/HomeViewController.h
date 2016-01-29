//
//  HomeViewController.h
//  cs442project
//
//  Created by Xiaoyang Lu on 4/5/14.
//  Copyright (c) 2014 Xiaoyang Lu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface HomeViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *menuItems;
- (IBAction)nextKeyboadrd:(id)sender;
- (IBAction)loginButtonPressed:(id)sender;


@end
