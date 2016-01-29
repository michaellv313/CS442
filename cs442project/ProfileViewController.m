//
//  ProfileViewController.m
//  cs442project
//
//  Created by Xiaoyang Lu on 4/1/14.
//  Copyright (c) 2014 Xiaoyang Lu. All rights reserved.
//

#import "ProfileViewController.h"
#import "SWRevealViewController.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController
{
    UILabel *username;
    UILabel *cwid;
    UITextField *phone;
    UITextField *address;
    UITextField *email;
    PFUser *currentUser;
}

@synthesize sidebarButton=_sidebarButton;

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
    self.title=@"Profile";
    self.tableView.separatorStyle = NO;
    _menuItems = @[@"username", @"cwid", @"phone", @"address", @"email"];
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    self.view.backgroundColor = [UIColor whiteColor];
    currentUser = [PFUser currentUser];
    UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    tapGr.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGr];
}
-(void)viewTapped:(UITapGestureRecognizer*)tapGr
{
    [phone resignFirstResponder];
    [address resignFirstResponder];
    [email resignFirstResponder];
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
        username = (UILabel*)[cell.contentView viewWithTag:1];
        username.text=currentUser.username;
    }
    if([cell.contentView viewWithTag:2])
    {
        cwid = (UILabel*)[cell.contentView viewWithTag:2];
        cwid.text=currentUser[@"CWID"];
    }
    if([cell.contentView viewWithTag:5])
    {
        phone = (UITextField*)[cell.contentView viewWithTag:5];
        [phone setEnabled:NO];
        phone.text=currentUser[@"phone"];
    }
    if([cell.contentView viewWithTag:6])
    {
        address = (UITextField*)[cell.contentView viewWithTag:6];
        [address setEnabled:NO];
        address.text=currentUser[@"address"];
    }
    if([cell.contentView viewWithTag:7])
    {
        email = (UITextField*)[cell.contentView viewWithTag:7];
        [email setEnabled:NO];
        email.text=currentUser[@"email"];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
        return 50;
}

- (IBAction)editButtonPressed:(id)sender {
    if([self.navigationItem.rightBarButtonItem.title isEqualToString:@"Edit"])
    {
        [phone setEnabled:YES];
        [address setEnabled:YES];
        [email setEnabled:YES];
        self.navigationItem.rightBarButtonItem.title=@"done";
    }
    else
    {
        currentUser[@"phone"]=phone.text;
        currentUser[@"address"]=address.text;
        currentUser[@"email"]=email.text;
        [currentUser saveInBackground];
        UIAlertView*alert = [[UIAlertView alloc]initWithTitle:@"Successful"
                                                      message:@"Alter Profile Successful."
                                                     delegate:nil
                                            cancelButtonTitle:@"Done"
                                            otherButtonTitles:nil];
        [alert show];
        self.navigationItem.rightBarButtonItem.title=@"Edit";
        [phone resignFirstResponder];
        [address resignFirstResponder];
        [email resignFirstResponder];
    }
    
    
}
@end
