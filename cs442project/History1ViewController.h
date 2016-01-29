//
//  History1ViewController.h
//  cs442project
//
//  Created by Zeyu Li on 4/1/14.
//  Copyright (c) 2014 Zeyu Li. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface History1ViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (strong,nonatomic)NSManagedObjectContext *context;
@end
