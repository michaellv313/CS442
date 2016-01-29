//
//  HomeViewController.m
//  cs442project
//
//  Created by Xiaoyang Lu on 4/5/14.
//  Copyright (c) 2014 Xiaoyang Lu. All rights reserved.
//

#import "HomeViewController.h"
#import "SidebarViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController
{
    UITextField *username;
    UITextField *password;
    UIButton *login;
    UIButton *signup;
    NSIndexPath *usernameIndexPath;
    NSIndexPath *passwordIndexPath;
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
    self.tableView.separatorStyle = NO;
    _menuItems = @[@"title", @"username", @"password", @"login", @"click", @"signup"];
    UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    tapGr.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGr];

}
-(void)viewTapped:(UITapGestureRecognizer*)tapGr
{

    [username resignFirstResponder];
    [password resignFirstResponder];
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
        username = (UITextField*)[cell.contentView viewWithTag:1];
    }
    if([cell.contentView viewWithTag:2])
    {
        password = (UITextField*)[cell.contentView viewWithTag:2];
    }
    if([cell.contentView viewWithTag:3])
    {
        login = (UIButton*)[cell.contentView viewWithTag:3];
        [login.layer setMasksToBounds:YES];
        [login.layer setCornerRadius:5];
    }
    if([cell.contentView viewWithTag:4])
    {
        signup = (UIButton*)[cell.contentView viewWithTag:4];
        [signup.layer setMasksToBounds:YES];
        [signup.layer setCornerRadius:5];
    }

    return cell;
}

- (void) textFieldDidBeginEditing:(UITextField *)textField
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
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
        return 88;
    return 44;
}

- (IBAction)nextKeyboadrd:(id)sender {
    [password becomeFirstResponder];
}

- (IBAction)loginButtonPressed:(id)sender {
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    CGRect rect = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
    self.view.frame = rect;
    [UIView commitAnimations];
    [PFUser logInWithUsernameInBackground:username.text password:password.text
                                    block:^(PFUser *user, NSError *error) {
                                        if (user) {
                                            [self performSegueWithIdentifier:@"login" sender:self];
                                            // Do stuff after successful login.
                                        } else {
                                            UIAlertView*alert = [[UIAlertView alloc]initWithTitle:@"Error"
                                                                                          message:@"Invalid username/password"
                                                                                         delegate:nil
                                                                                cancelButtonTitle:@"Retry"
                                                                                otherButtonTitles:nil];  
                                            [alert show];
                                            // The login failed. Check error to see why.
                                        }
                                    }];
}


@end
