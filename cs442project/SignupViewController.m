//
//  SignupViewController.m
//  cs442project
//
//  Created by Xiaoyang Lu on 4/8/14.
//  Copyright (c) 2014 Xiaoyang Lu. All rights reserved.
//

#import "SignupViewController.h"

@interface SignupViewController ()

@end

@implementation SignupViewController
{
    UITextField *CWID;
    UITextField *username;
    UITextField *password;
    UITextField *repassword;
    UITextField *phone;
    UITextField *email;
    UITextField *address;
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
    self.navigationController.navigationBarHidden=YES;
    self.tableview.separatorStyle = NO;
    _menuItems = @[@"title", @"CWID", @"username", @"password", @"repassword", @"phone", @"email", @"address", @"submit"];
    UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    tapGr.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGr];
    // Do any additional setup after loading the view.
}

-(void)viewTapped:(UITapGestureRecognizer*)tapGr
{
    [CWID resignFirstResponder];
    [username resignFirstResponder];
    [password resignFirstResponder];
    [repassword resignFirstResponder];
    [phone resignFirstResponder];
    [email resignFirstResponder];
    [address resignFirstResponder];
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
    if([cell.contentView viewWithTag:7])
    {
        CWID = (UITextField*)[cell.contentView viewWithTag:7];
    }
    if([cell.contentView viewWithTag:1])
    {
        username = (UITextField*)[cell.contentView viewWithTag:1];
    }
    if([cell.contentView viewWithTag:2])
    {
        password = (UITextField*)[cell.contentView viewWithTag:2];
    }
    if([cell.contentView viewWithTag:3])
    {
        repassword = (UITextField*)[cell.contentView viewWithTag:3];
    }
    if([cell.contentView viewWithTag:4])
    {
        phone = (UITextField*)[cell.contentView viewWithTag:4];
    }
    if([cell.contentView viewWithTag:5])
    {
        email = (UITextField*)[cell.contentView viewWithTag:5];
    }
    if([cell.contentView viewWithTag:6])
    {
        address = (UITextField*)[cell.contentView viewWithTag:6];
    }
       return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
        return 88;
    return 44;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
 {
         CGRect frame = textField.frame;
         int offset = frame.origin.y +422 - (self.view.frame.size.height - 240);//键盘高度216
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
}


- (IBAction)nextKeyboard:(id)sender {
    if([CWID isFirstResponder])
        [username becomeFirstResponder];
    else if([username isFirstResponder])
        [password becomeFirstResponder];
    else if([password isFirstResponder])
        [repassword becomeFirstResponder];
    else if([repassword isFirstResponder])
        [phone becomeFirstResponder];
    else if([phone isFirstResponder])
        [email becomeFirstResponder];
    else
        [address becomeFirstResponder];
   
}

- (IBAction)submitButtonPressed:(id)sender {
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    CGRect rect = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
    self.view.frame = rect;
    [UIView commitAnimations];
    if(![password.text isEqualToString:repassword.text])
    {
        UIAlertView*alert = [[UIAlertView alloc]initWithTitle:@"Error"
                                                      message:@"Password and Re-passwod are not same"
                                                     delegate:nil
                                            cancelButtonTitle:@"Retry"
                                            otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        PFUser *user = [PFUser user];
        user[@"CWID"] = CWID.text;
        user.username = username.text;
        user.password = password.text;
        user.email = email.text;
        // other fields can be set just like with PFObject
        user[@"phone"] = phone.text;
        user[@"address"] = address.text;
        [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            UIAlertView*alert = [[UIAlertView alloc]initWithTitle:@"Successful"
                                                          message:@"Sign up successful"
                                                         delegate:nil
                                                cancelButtonTitle:@"done"
                                                otherButtonTitles:nil];
            [alert show];
            [self performSegueWithIdentifier:@"submit" sender:self];
            // Hooray! Let them use the app now.
        } else {
            NSString *errorString = [error userInfo][@"error"];
            UIAlertView*alert = [[UIAlertView alloc]initWithTitle:@"Error"
                                                          message:errorString
                                                         delegate:nil
                                                cancelButtonTitle:@"retry"
                                                otherButtonTitles:nil];
            [alert show];
            // Show the errorString somewhere and let the user try again.
        }
        }];
    }
}
@end
