//
//  HistoryDetailViewController.h
//  cs442project
//
//  Created by Zeyu Li on 4/1/14.
//  Copyright (c) 2014 Zeyu Li. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HistoryDetailViewController : UIViewController
@property (strong, nonatomic) NSMutableDictionary *details;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *state;
@property (weak, nonatomic) IBOutlet UILabel *from;
@property (weak, nonatomic) IBOutlet UILabel *to;
@property (weak, nonatomic) IBOutlet UILabel *number;
@property (weak, nonatomic) IBOutlet UILabel *car;
@property (weak, nonatomic) IBOutlet UILabel *driver;

@end
