//
//  Building1ViewController.m
//  cs442project
//
//  Created by Zeyu Li on 4/1/14.
//  Copyright (c) 2014 Zeyu Li. All rights reserved.
//

#import "Building1ViewController.h"
#import "BuildingDetailViewController.h"
#import "SWRevealViewController.h"

@interface Building1ViewController ()

@end

@implementation Building1ViewController
{
}

@synthesize sidebarButton=_sidebarButton;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=self.category;
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    self.view.backgroundColor = [UIColor whiteColor];
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    if([self.category isEqualToString:@"Building"])
        _menuItems = @[@"Stuart Building", @"Engineering Building"];
    else
        _menuItems = @[@"R1", @"R2"];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

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
    return _menuItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.textLabel.text=_menuItems[indexPath.row];
    return cell;
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    BuildingDetailViewController *dest=segue.destinationViewController;
    NSInteger _selectedIndex=[self.tableView indexPathForSelectedRow].row;
    dest.title=_menuItems[_selectedIndex];
    dest.category=self.category;
}

@end
