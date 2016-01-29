//
//  YourReviewsViewController.m
//  cs442project
//
//  Created by Xiaoyang Lu on 4/1/14.
//  Copyright (c) 2014 Xiaoyang Lu. All rights reserved.
//

#import "YourReviewsViewController.h"
#import "SWRevealViewController.h"
#import "YourDetailReviewsViewController.h"
#import "Review.h"
#import "AppDelegate.h"

@interface YourReviewsViewController ()
{
    NSMutableArray *_objects;
    NSMutableArray *_objects2;
}

@end

@implementation YourReviewsViewController
{
    NSArray *fetchObject;
    int i;
    PFUser *currentUser;
    Review *coreData;
}

@synthesize sidebarButton=_sidebarButton;
@synthesize context;

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
    self.title=@"Review List";
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    self.view.backgroundColor = [UIColor whiteColor];
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    currentUser = [PFUser currentUser];
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    self.context = delegate.managedObjectContext;
    NSError *error = nil;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Review"inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    fetchObject = [context executeFetchRequest:fetchRequest error:&error];
    coreData = [NSEntityDescription insertNewObjectForEntityForName:@"Review" inManagedObjectContext:context];
    i = 0;
    _objects = [[NSMutableArray alloc] init];
    _objects2 = [[NSMutableArray alloc] init];
    for (NSManagedObject *info in fetchObject) {
        if([[info valueForKey:@"cwid"] isEqualToString:currentUser[@"CWID"]])
        {
            [_objects insertObject:[info valueForKey:@"time"] atIndex:i];
            [_objects2 insertObject:[info valueForKey:@"category"] atIndex:i];
            i++;
        }
    }
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
    return i;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    NSDateFormatter *formate = [[NSDateFormatter alloc] init];
    [formate setDateStyle:NSDateFormatterShortStyle];
    [formate setTimeStyle:NSDateFormatterShortStyle];
    NSString *formateDateString = [formate stringFromDate:[_objects objectAtIndex:indexPath.row]];
    cell.textLabel.text=[[formateDateString stringByAppendingString:@" on "]stringByAppendingString:[_objects2 objectAtIndex:indexPath.row]];
    return cell;
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    YourDetailReviewsViewController *dest=segue.destinationViewController;
    NSInteger _selectedIndex=[self.tableView indexPathForSelectedRow].row;
    dest.date=[_objects objectAtIndex:_selectedIndex];
}



@end
