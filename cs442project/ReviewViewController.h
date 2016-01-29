//
//  ReviewViewController.h
//  cs442project
//
//  Created by Xiaoyang Lu on 4/1/14.
//  Copyright (c) 2014 Xiaoyang Lu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface ReviewViewController : UIViewController<UITextViewDelegate,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) NSString *category;
@property (strong, nonatomic) NSString *part;
@property (strong,nonatomic)NSManagedObjectContext *context;
- (IBAction)doneButtonPressed:(id)sender;


@end
