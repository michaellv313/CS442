//
//  CurrentStatusViewController.m
//  cs442project
//
//  Created by Xiaoyang Lu on 4/1/14.
//  Copyright (c) 2014 Xiaoyang Lu. All rights reserved.
//

#import "CurrentStatusViewController.h"
#import "SWRevealViewController.h"
#import "Request.h"
#import "AppDelegate.h"

@interface CurrentStatusViewController ()

@end

@implementation CurrentStatusViewController
{
    UILabel *state;
    UILabel *message;
    UILabel *from;
    UILabel *to;
    UILabel *number;
    UILabel *time;
    UILabel *car;
    UILabel *driver;
    UIButton *cancel;
    UIButton *arrived;
    int i;
    NSString *stateContent;
    NSString *messageContent;
    NSString *fromContent;
    NSString *toContent;
    NSNumber *numberContent;
    NSDate *timeContent;
    NSNumber *carContent;
    NSString *driverContent;
    NSArray *fetchObject;
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
    //data = [[NSMutableDictionary alloc] initWithContentsOfFile:filename];
	// Do any additional setup after loading the view.
    self.title=@"Current Reservations Status";
    self.tableView.separatorStyle = NO;
    _menuItems = @[@"state", @"message", @"from", @"to", @"numberofpeople", @"time", @"carnumber", @"driver", @"button"];
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    self.view.backgroundColor = [UIColor whiteColor];
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    self.context = delegate.managedObjectContext;
    NSError *error = nil;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Request"inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    fetchObject = [context executeFetchRequest:fetchRequest error:&error];
    i = 0;
    for (NSManagedObject *info in fetchObject) {
        PFUser *currentUser = [PFUser currentUser];
        //NSLog(@"%@",[info valueForKey:@"time"]);
        //NSLog(@"%@",currentUser[@"lasttime"]);
        if([[info valueForKey:@"cwid"] isEqualToString:currentUser[@"CWID"]]&&[currentUser[@"lasttime"] isEqualToDate:[info valueForKey:@"time"]])
        {
            i++;
            stateContent = [info valueForKey:@"state"];
            messageContent = [info valueForKey:@"message"];
            fromContent = [info valueForKey:@"from"];
            toContent = [info valueForKey:@"to"];
            numberContent = [info valueForKey:@"number"];
            timeContent = [info valueForKey:@"time"];
            carContent = [info valueForKey:@"car"];
            driverContent = [info valueForKey:@"driver"];
        }
    }
    
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
        state = (UILabel*)[cell.contentView viewWithTag:1];
        state.text = stateContent;
    }
    if([cell.contentView viewWithTag:2])
    {
        message = (UILabel*)[cell.contentView viewWithTag:2];
        message.text = messageContent;
    }
    if([cell.contentView viewWithTag:3])
    {
        from = (UILabel*)[cell.contentView viewWithTag:3];
        from.text = fromContent;
    }
    if([cell.contentView viewWithTag:4])
    {
        to = (UILabel*)[cell.contentView viewWithTag:4];
        to.text = toContent;
    }
    if([cell.contentView viewWithTag:5])
    {
        number = (UILabel*)[cell.contentView viewWithTag:5];
        NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
        number.text = [numberFormatter stringFromNumber:numberContent];
    }
    if([cell.contentView viewWithTag:6])
    {
        time = (UILabel*)[cell.contentView viewWithTag:6];
        NSDateFormatter *formate = [[NSDateFormatter alloc] init];
        [formate setDateStyle:NSDateFormatterMediumStyle];
        [formate setTimeStyle:NSDateFormatterMediumStyle];
        NSString *formateDateString = [formate stringFromDate:timeContent];
        time.text = formateDateString;
    }
    if([cell.contentView viewWithTag:7])
    {
        car = (UILabel*)[cell.contentView viewWithTag:7];
        NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
        car.text = [numberFormatter stringFromNumber:carContent];
    }
    if([cell.contentView viewWithTag:8])
    {
        driver = (UILabel*)[cell.contentView viewWithTag:8];
        driver.text = driverContent;
    }
    if([cell.contentView viewWithTag:9])
    {
        cancel = (UIButton*)[cell.contentView viewWithTag:9];
        [cancel.layer setMasksToBounds:YES];
        [cancel.layer setCornerRadius:5];
    }
    if([cell.contentView viewWithTag:10])
    {
        arrived = (UIButton*)[cell.contentView viewWithTag:10];
        [arrived.layer setMasksToBounds:YES];
        [arrived.layer setCornerRadius:5];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}

- (IBAction)cancelButtonPressed:(id)sender {
    PFUser *currentUser = [PFUser currentUser];
    for (NSManagedObject *info in fetchObject){
        if ([[info valueForKey:@"state"] isEqualToString:@"Accepted"]&&[[info valueForKey:@"cwid"] isEqualToString:currentUser[@"CWID"]])
        {
            [info setValue:@"Canceled" forKey:@"state"];
            [info setValue:@"Please reserve again" forKey:@"message"];
            NSError *error = nil;
            if (![context save:&error]) {
                NSLog(@"%@",[error localizedDescription]);
            }
            stateContent=@"Canceled";
            messageContent=@"Please reserve again";
        }
    }
    PFQuery *query = [PFQuery queryWithClassName:@"Request"];
    [query whereKey:@"CWID" equalTo:currentUser[@"CWID"]];
    [query whereKey:@"state" equalTo:@"accepted"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects1, NSError *error)
     {
         if(!error&&[objects1 count]!=0)
         {
             for (PFObject *object in objects1) {
                 object[@"state"]=@"canceled";
                 [object saveInBackground];
             }
             PFQuery *query2 = [PFQuery queryWithClassName:@"mapping"];
             [query2 whereKey:@"CWID" equalTo:currentUser[@"CWID"]];
             [query2 findObjectsInBackgroundWithBlock:^(NSArray *objects2, NSError *error)
              {
                  if(!error)
                  {
                      for (PFObject *object in objects2) {
                          object[@"state"]=@"canceled";
                          [object saveInBackground];
                      }
                  }
              }];
             PFQuery *query3 = [PFQuery queryWithClassName:@"Cars"];
             [query3 whereKey:@"carNumber" equalTo:carContent];
             [query3 whereKey:@"state" notEqualTo:@"NA"];
             [query3 findObjectsInBackgroundWithBlock:^(NSArray *objects3, NSError *error)
              {
                  if(!error)
                  {
                      for (PFObject *object in objects3) {
                          object[@"state"]=@"available";
                          [object saveInBackground];
                      }
                  }
              }];
             PFQuery *query4 = [PFQuery queryWithClassName:@"Cars"];
             [query4 getObjectInBackgroundWithId:@"ejpRmU8awd" block:^(PFObject *re, NSError *error)
              {
                  //[re incrementKey:@"carNumber"];
                  re[@"carNumber"]=[NSNumber numberWithInteger:[re[@"carNumber"] integerValue]-1 ];
                  if([re[@"carNumber"] integerValue]==-1)
                  {
                      re[@"carNumber"]=@10;
                  }
                  [re saveInBackground];
              }];
             UIAlertView*alert = [[UIAlertView alloc]initWithTitle:@"Successful"
                                                           message:@"You have canceled the reservation."
                                                          delegate:nil
                                                 cancelButtonTitle:@"Done"
                                                 otherButtonTitles:nil];
             [alert show];
             [self.tableView reloadData];
         }
         else{
             UIAlertView*alert = [[UIAlertView alloc]initWithTitle:@"Error"
                                                           message:@"You haven't reserved any car"
                                                          delegate:nil
                                                 cancelButtonTitle:@"Done"
                                                 otherButtonTitles:nil];
             [alert show];

         }
     }];
}

- (IBAction)arrivedButtonPressed:(id)sender {
    PFUser *currentUser = [PFUser currentUser];
    for (NSManagedObject *info in fetchObject){
        if ([[info valueForKey:@"state"] isEqualToString:@"Accepted"]&&[[info valueForKey:@"cwid"] isEqualToString:currentUser[@"CWID"]])
        {
            [info setValue:@"Arrived" forKey:@"state"];
            [info setValue:@"Thanks!!!" forKey:@"message"];
            NSError *error = nil;
            if (![context save:&error]) {
                NSLog(@"%@",[error localizedDescription]);
            }
            stateContent=@"Arrived";
            messageContent=@"Thanks";
        }
    }
    PFQuery *query = [PFQuery queryWithClassName:@"Request"];
    [query whereKey:@"CWID" equalTo:currentUser[@"CWID"]];
    [query whereKey:@"state" equalTo:@"accepted"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects1, NSError *error)
     {
         if(!error&&[objects1 count]!=0)
         {
             for (PFObject *object in objects1) {
                 object[@"state"]=@"arrived";
                 [object saveInBackground];
             }
             PFQuery *query2 = [PFQuery queryWithClassName:@"mapping"];
             [query2 whereKey:@"CWID" equalTo:currentUser[@"CWID"]];
             [query2 findObjectsInBackgroundWithBlock:^(NSArray *objects2, NSError *error)
              {
                  if(!error)
                  {
                      for (PFObject *object in objects2) {
                          object[@"state"]=@"arrived";
                          [object saveInBackground];
                      }
                  }
              }];
             PFQuery *query3 = [PFQuery queryWithClassName:@"Cars"];
             [query3 whereKey:@"carNumber" equalTo:carContent];
             [query3 whereKey:@"state" notEqualTo:@"NA"];
             [query3 findObjectsInBackgroundWithBlock:^(NSArray *objects3, NSError *error)
              {
                  if(!error)
                  {
                      for (PFObject *object in objects3) {
                          object[@"state"]=@"available";
                          [object saveInBackground];
                      }
                  }
              }];
             UIAlertView*alert = [[UIAlertView alloc]initWithTitle:@"Successful"
                                                           message:@"Thanks for your using our app"
                                                          delegate:nil
                                                 cancelButtonTitle:@"Done"
                                                 otherButtonTitles:nil];
             [alert show];
             [self.tableView reloadData];
         }
         else{
             UIAlertView*alert = [[UIAlertView alloc]initWithTitle:@"Error"
                                                           message:@"You haven't reserved any car"
                                                          delegate:nil
                                                 cancelButtonTitle:@"Done"
                                                 otherButtonTitles:nil];
             [alert show];
         }
     }];
    
}
@end
