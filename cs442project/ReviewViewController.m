//
//  ReviewViewController.m
//  cs442project
//
//  Created by Xiaoyang Lu on 4/1/14.
//  Copyright (c) 2014 Zeyu Li. All rights reserved.
//

#import "ReviewViewController.h"
#import "Review.h"
#import "AppDelegate.h"

@interface ReviewViewController ()

@end

@implementation ReviewViewController

{
    UIBarButtonItem *doneButton;
    Review *coreData;
    NSFetchRequest *fetchRequest;
    NSEntityDescription *entity;
}
@synthesize context;

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
    self.title=@"Review";
    [self.textView.layer setBorderWidth:1];
    [self.textView.layer setCornerRadius:10];
    self.textView.selectedRange=NSMakeRange(0,0);
    doneButton=self.navigationItem.rightBarButtonItem;
    self.navigationItem.rightBarButtonItem=nil;
    UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    tapGr.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGr];
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    self.context = delegate.managedObjectContext;
    coreData = [NSEntityDescription insertNewObjectForEntityForName:@"Review" inManagedObjectContext:context];
}

-(void)viewTapped:(UITapGestureRecognizer*)tapGr
{
    [self.textView resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    self.navigationItem.rightBarButtonItem=doneButton;
}

- (IBAction)doneButtonPressed:(id)sender {
    
    PFObject *review = [PFObject objectWithClassName:@"Review"];
    PFUser *currentUser = [PFUser currentUser];
    review[@"CWID"]=currentUser[@"CWID"];
    review[@"category"]=self.category;
    review[@"part"]=self.part;
    review[@"time"]=[NSDate date];
    review[@"review"]=self.textView.text;
    [review saveInBackground];
    coreData.cwid=currentUser[@"CWID"];
    coreData.category=self.category;
    coreData.part=self.part;
    coreData.time=[NSDate date];
    coreData.review=self.textView.text;
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"%@",[error localizedDescription]);
    }
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Confirm Submit"
                                                  message:@"You have reviewed successful"
                                                 delegate:nil
                                        cancelButtonTitle:@"Done"
                                        otherButtonTitles:nil];
    [alert show];
    [self performSegueWithIdentifier:@"done" sender:self];
    
}

@end
