//
//  PSRViewController.h
//  cs442project
//
//  Created by Xiaoyang Lu on 3/31/14.
//  Copyright (c) 2014 Zeyu Li. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface ReservationViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate>
@property (strong,nonatomic)NSManagedObjectContext *context;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIPickerView *numberPicker;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (nonatomic, strong) NSArray *menuItems;
@property (strong, nonatomic) NSArray *numberValue;
@property (strong, nonatomic) PFObject *result;
@property (weak, nonatomic) IBOutlet UIView *subView;
- (IBAction)chooseNumber:(id)sender;
- (IBAction)selectTime:(id)sender;
- (IBAction)doneChooseNumber:(id)sender;
- (IBAction)submitButtonPressed:(id)sender;


@end
