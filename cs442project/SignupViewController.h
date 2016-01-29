//
//  SignupViewController.h
//  cs442project
//
//  Created by Xiaoyang Lu on 4/8/14.
//  Copyright (c) 2014 Xiaoyang Lu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface SignupViewController : UIViewController <UITableViewDataSource, UITableViewDelegate,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic, strong) NSArray *menuItems;
- (IBAction)nextKeyboard:(id)sender;
- (IBAction)submitButtonPressed:(id)sender;

@end
