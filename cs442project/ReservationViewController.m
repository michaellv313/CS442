//
//  PSRViewController.m
//  cs442project
//
//  Created by Xiaoyang Lu on 3/31/14.
//  Copyright (c) 2014 Xiaoyang Lu. All rights reserved.
//

#import "ReservationViewController.h"
#import "SWRevealViewController.h"
#import "CurrentStatusViewController.h"
#import "Request.h"
#import "AppDelegate.h"

@interface ReservationViewController ()

@end

@implementation ReservationViewController
{
    UIButton *submit;
    UILabel *cwid;
    UITextField *currentlocation;
    UITextField *destination;
    UIButton *numberOfPeople;
    UIButton *chooseDate;
    NSDate *curDate;
    Request *coreData;
    NSFetchRequest *fetchRequest;
    NSEntityDescription *entity;
}

@synthesize sidebarButton=_sidebarButton;
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
    _subView.hidden=YES;
    [self.view addSubview:_subView];
    self.title=@"Public Safety Reservation";
    self.tableView.separatorStyle = NO;
    _menuItems = @[@"title", @"cwid", @"currentlocation", @"destination", @"numberofpeople", @"timetogo", @"submit"];
    // Do any additional setup after loading the view.,
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    self.numberValue  = [[NSArray alloc]initWithObjects:@"1", @"2", @"3", @"4" , nil];
    UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    tapGr.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGr];
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    self.context = delegate.managedObjectContext;
    coreData = [NSEntityDescription insertNewObjectForEntityForName:@"Request" inManagedObjectContext:context];
}

-(void)viewTapped:(UITapGestureRecognizer*)tapGr
{
    //[cwid resignFirstResponder];
    [currentlocation resignFirstResponder];
    [destination resignFirstResponder];
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    CGRect rect = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
    self.view.frame = rect;
    [UIView commitAnimations];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.menuItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [self.menuItems objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if([cell.contentView viewWithTag:1])
    {
        cwid = (UILabel*)[cell.contentView viewWithTag:1];
        //cwid.text=@"1111";
        PFUser *currentUser = [PFUser currentUser];
        if (currentUser && [CellIdentifier isEqualToString:@"cwid"])
        {
            cwid.text = currentUser[@"CWID"];
            //NSLog(@"%@",cwid.text);
        }
        else {
        }
    }
    if([cell.contentView viewWithTag:2])
    {
        currentlocation = (UITextField*)[cell.contentView viewWithTag:2];
    }
    if([cell.contentView viewWithTag:3])
    {
        destination = (UITextField*)[cell.contentView viewWithTag:3];
    }
    if([cell.contentView viewWithTag:4])
    {
        numberOfPeople = (UIButton*)[cell.contentView viewWithTag:4];
        [numberOfPeople.layer setMasksToBounds:YES];
        [numberOfPeople.layer setCornerRadius:5];
        [numberOfPeople.layer setBorderWidth:1.0];
        [numberOfPeople.layer setBorderColor:[[UIColor redColor]CGColor]];
    }
    if([cell.contentView viewWithTag:5])
    {
        chooseDate = (UIButton*)[cell.contentView viewWithTag:5];
        [chooseDate.layer setMasksToBounds:YES];
        [chooseDate.layer setCornerRadius:5];
        [chooseDate.layer setBorderWidth:1.0];
        [chooseDate.layer setBorderColor:[[UIColor redColor]CGColor]];
    }
    if([cell.contentView viewWithTag:10])
    {
        submit = (UIButton*)[cell.contentView viewWithTag:10];
        [submit.layer setMasksToBounds:YES];
        [submit.layer setCornerRadius:5];
    }
    [cell setBackgroundColor:[UIColor clearColor]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0||indexPath.row == 6)
        return 88;
    return 60;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect frame = textField.frame;
    int offset = frame.origin.y +480 - (self.view.frame.size.height - 240);
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    float width = self.view.frame.size.width;
    float height = self.view.frame.size.height;
    if(offset > 0)
    {
        CGRect rect = CGRectMake(0.0f, -offset,width,height);
        self.view.frame = rect;
    }
    [UIView commitAnimations];
    _subView.hidden=YES;
}

//picker view
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent: (NSInteger)component
{
    return 4;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row   forComponent:(NSInteger)component
{
    return [self.numberValue objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row   inComponent:(NSInteger)componen
{
    [numberOfPeople setTitle:[self.numberValue objectAtIndex:row] forState:UIControlStateNormal];
}

- (IBAction)chooseNumber:(id)sender {
    _subView.hidden=NO;
    self.numberPicker.hidden=NO;
    self.datePicker.hidden=YES;
}

- (IBAction)selectTime:(id)sender {
    _subView.hidden=NO;
    self.numberPicker.hidden=YES;
    self.datePicker.hidden=NO;
}

- (IBAction)doneChooseNumber:(id)sender {
    _subView.hidden=YES;
    if(self.datePicker.hidden==NO)
    {
        curDate =[self.datePicker date];
        NSDateFormatter *formate = [[NSDateFormatter alloc] init];
        [formate setDateStyle:NSDateFormatterMediumStyle];
        [formate setTimeStyle:NSDateFormatterMediumStyle];
        NSString *formateDateString = [formate stringFromDate:curDate];
        [chooseDate setTitle:formateDateString forState:UIControlStateNormal];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
}


- (IBAction)submitButtonPressed:(id)sender {
    PFObject *request = [PFObject objectWithClassName:@"Request"];
    if (currentlocation.text.length==0)
    {
        UIAlertView*alert = [[UIAlertView alloc]initWithTitle:@"Error"
                                                      message:@"Current location cannot be null"
                                                     delegate:nil
                                            cancelButtonTitle:@"Retry"
                                            otherButtonTitles:nil];
        [alert show];
    }
    else if (destination.text.length==0)
    {
        UIAlertView*alert = [[UIAlertView alloc]initWithTitle:@"Error"
                                                  message:@"Destination cannot be null"
                                                 delegate:nil
                                        cancelButtonTitle:@"Retry"
                                        otherButtonTitles:nil];
        [alert show];
    }
    else if ([[chooseDate titleForState:UIControlStateNormal] isEqual:@"Select Time"])
    {
        UIAlertView*alert = [[UIAlertView alloc]initWithTitle:@"Error"
                                                      message:@"Please choose time"
                                                     delegate:nil
                                            cancelButtonTitle:@"Retry"
                                            otherButtonTitles:nil];
        [alert show];
    }
    else{
        request[@"CWID"]=cwid.text;
        request[@"currentlocation"]=currentlocation.text;
        request[@"destination"]=destination.text;
        NSNumber *number=[NSNumber numberWithInt:[[numberOfPeople titleForState:UIControlStateNormal] intValue]];
        request[@"numberofpeople"]=number;
        request[@"time"]=curDate;
        PFUser *currentUser = [PFUser currentUser];
        [currentUser saveInBackground];
        [PFCloud callFunctionInBackground:@"checkRequest"
                           withParameters:@{@"CWID": cwid.text}
                                    block:^(NSNumber *number, NSError *error) {
                                        //NSLog(@"%@",number);
                                        if (!error) {
                                            if([number intValue]>=1)
                                            {
                                                
                                                UIAlertView*alert = [[UIAlertView alloc]initWithTitle:@"Error"
                                                                                          message:@"You have requested."
                                                                                         delegate:nil
                                                                                cancelButtonTitle:@"Done"
                                                                                otherButtonTitles:nil];
                                                [alert show];
                                                [self performSegueWithIdentifier:@"submit" sender:self];
                                                
                                            }
                                            else
                                            {
                                                currentUser[@"lasttime"]=curDate;
                                                [currentUser saveInBackground];
                                                UIAlertView*alert = [[UIAlertView alloc]initWithTitle:@"Successful"
                                                                                              message:@"Your request has been submitted"
                                                                                             delegate:nil
                                                                                    cancelButtonTitle:@"OK"
                                                                                    otherButtonTitles:nil];
                                                [alert show];
                                                [PFCloud callFunctionInBackground:@"chooseCar"
                                                                   withParameters:@{}
                                                                            block:^(PFObject *ttt, NSError *error) {
                                                                                if (!error) {
                                                                                    //NSLog(@"%@",ttt);
                                                                                    if([ttt isEqual:@"No available car"])
                                                                                    {
                                                                                        coreData.cwid=cwid.text;
                                                                                        coreData.state=@"Declined";
                                                                                        coreData.message=@"No available car";
                                                                                        coreData.from=currentlocation.text;
                                                                                        coreData.to=destination.text;
                                                                                        coreData.number=[NSNumber numberWithInt:[[numberOfPeople titleForState:UIControlStateNormal] intValue]];
                                                                                        coreData.time=curDate;
                                                                                        coreData.car=@99999999;
                                                                                        coreData.driver=@"Not Available";
                                                                                        NSError *error = nil;
                                                                                        if (![context save:&error]) {
                                                                                            NSLog(@"%@",[error localizedDescription]);
                                                                                        }
                                                                                        
                                                                                        [self performSegueWithIdentifier:@"submit" sender:self];
                                                                                        request[@"state"]=@"declined";
                                                                                        [request saveInBackground];
                                                                                    }
                                                                                    else {
                                                                                    coreData.cwid=cwid.text;
                                                                                    coreData.state=@"Accepted";
                                                                                    coreData.message=@"Wait your car";
                                                                                    coreData.from=currentlocation.text;
                                                                                    coreData.to=destination.text;
                                                                                    coreData.number=[NSNumber numberWithInt:[[numberOfPeople titleForState:UIControlStateNormal] intValue]];
                                                                                    coreData.time=curDate;
                                                                                    request[@"state"]=@"accepted";
                                                                                    [request saveInBackground];
                                                                                    PFQuery *query = [PFQuery queryWithClassName:@"Cars"];
                                                                                    [query getObjectInBackgroundWithId:@"ejpRmU8awd" block:^(PFObject *re, NSError *error)
                                                                                     {
                                                                                         [re incrementKey:@"carNumber"];
                                                                                         if([re[@"carNumber"] integerValue]==11)
                                                                                         {
                                                                                             re[@"carNumber"]=@0;
                                                                                         }
                                                                                         [re saveInBackground];
                                                                                     }];
                                                                                        self.result = [PFObject objectWithClassName:@"mapping"];
                                                                                        self.result[@"CWID"]=cwid.text;
                                                                                        NSNumber *tt = [NSNumber numberWithInt:[[ttt objectForKey:@"carNumber"] intValue]];
                                                                                        self.result[@"carNumber"]=tt;
                                                                                        self.result[@"time"]=curDate;
                                                                                        [self.result saveInBackground];
                                                                                        coreData.car=tt;
                                                                                        PFQuery *query2 = [PFQuery queryWithClassName:@"Cars"];
                                                                                        [query2 whereKey:@"carNumber" equalTo:tt];
                                                                                        [query2 whereKey:@"state" notEqualTo:@"NA"];
                                                                                        [query2 findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
                                                                                         {
                                                                                             if (!error) {
                                                                                                 objects[0][@"state"]=@"in use";
                                                                                                 [objects[0] saveInBackground];
                                                                                                 coreData.driver=objects[0][@"driver"];
                                                                                                 NSError *error = nil;
                                                                                                 if (![context save:&error]) {
                                                                                                     NSLog(@"%@",[error localizedDescription]);
                                                                                                 }
                                                                                                                                                                                                  [self performSegueWithIdentifier:@"submit" sender:self];
                                                                                                 
                                                                                             } else {
                                                                                                 NSLog(@"Error: %@ %@", error, [error userInfo]);
                                                                                             }
                                                                                        
                                                                                         }];
                                                                                        
                                                                                    }
                                                                                }
                                                                            }];
                                            }
                                        
                                        }
                                        
                                        else{
                                        }
                                    }];
       
    }
}
@end
