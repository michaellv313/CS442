//
//  BuildingDetailViewController.m
//  cs442project
//
//  Created by Zeyu Li on 4/1/14.
//  Copyright (c) 2014 Zeyu Li. All rights reserved.
//

#import "BuildingDetailViewController.h"
#import "ReviewViewController.h"

@interface BuildingDetailViewController ()

@end

@implementation BuildingDetailViewController
{
    PFQuery *query;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.topItem.title = @"";
    UITapGestureRecognizer*tapRecognizer1=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickurl:)];
    self.link.userInteractionEnabled=YES;
    [self.link addGestureRecognizer:tapRecognizer1];
    self.imageView.clipsToBounds  = YES;
    self.imageView.transform = CGAffineTransformMakeScale(0.7, 0.7);
    self.imageView.contentMode=UIViewContentModeCenter;
    if([self.category isEqualToString:@"Building"])
    {
        query = [PFQuery queryWithClassName:@"Building"];
        [query whereKey:@"building" equalTo:self.title];
    }
    else
    {
        query = [PFQuery queryWithClassName:@"Restaurant"];
        [query whereKey:@"name" equalTo:self.title];
    }
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
                for (PFObject *object in objects) {
                    self.hour.text=object[@"hour"];
                    self.address.text=object[@"location"];
                    self.use.text=object[@"use"];
                    PFFile *userImageFile = object[@"image"];
                        [userImageFile getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
                            if (!error) {
                                self.imageView.image = [UIImage imageWithData:imageData];
                            }
                        }];
                }
            }
        }];
}
-(void)clickurl:(id)sender
{
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        for (PFObject *object in objects) {
            NSString* path=object[@"link"];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:path]];
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    ReviewViewController *dest=segue.destinationViewController;
    dest.category=self.category;
    dest.part=self.title;
}

@end
