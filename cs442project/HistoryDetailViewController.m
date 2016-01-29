//
//  HistoryDetailViewController.m
//  cs442project
//
//  Created by Zeyu Li on 4/1/14.
//  Copyright (c) 2014 Zeyu Li. All rights reserved.
//

#import "HistoryDetailViewController.h"

@interface HistoryDetailViewController ()

@end

@implementation HistoryDetailViewController

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
    self.title=@"Details";
    self.navigationController.navigationBar.topItem.title = @"";
    NSDateFormatter *formate = [[NSDateFormatter alloc] init];
    [formate setDateStyle:NSDateFormatterMediumStyle];
    [formate setTimeStyle:NSDateFormatterMediumStyle];
    NSString *formateDateString = [formate stringFromDate:[self.details objectForKey:@"time"]];
    self.time.text=formateDateString;
    self.state.text=[self.details objectForKey:@"state"];
    self.from.text=[self.details objectForKey:@"from"];
    self.to.text=[self.details objectForKey:@"to"];
    NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
    self.number.text = [numberFormatter stringFromNumber:[self.details objectForKey:@"number"]];
    self.car.text=[numberFormatter stringFromNumber:[self.details objectForKey:@"car"]];
    self.driver.text=[self.details objectForKey:@"driver"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
