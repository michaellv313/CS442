//
//  BuildingDetailViewController.h
//  cs442project
//
//  Created by Zeyu Li on 4/1/14.
//  Copyright (c) 2014 Zeyu Li. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface BuildingDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *hour;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *use;
@property (weak, nonatomic) IBOutlet UILabel *link;
@property (strong, nonatomic) NSString *category;



@end
