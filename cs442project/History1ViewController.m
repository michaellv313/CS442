//
//  History1ViewController.m
//  cs442project
//
//  Created by Zeyu Li on 4/1/14.
//  Copyright (c) 2014 Zeyu Li. All rights reserved.
//

#import "History1ViewController.h"
#import "HistoryDetailViewController.h"
#import "SWRevealViewController.h"
#import "Request.h"
#import "AppDelegate.h"

@interface History1ViewController ()
{
    NSMutableArray *_objects;
}

@end

@implementation History1ViewController
{
    NSArray *fetchObject;
    int i;
    PFUser *currentUser;
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
    self.title=@"History";
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
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Request"inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    fetchObject = [context executeFetchRequest:fetchRequest error:&error];
    i = 0;
    _objects = [[NSMutableArray alloc] init];
    for (NSManagedObject *info in fetchObject) {
        if([[info valueForKey:@"cwid"] isEqualToString:currentUser[@"CWID"]])
        {
            [_objects insertObject:[info valueForKey:@"time"] atIndex:i];
            i++;
        }
    }
//    for(int j=0;j<count;j++)
//    {
//        [_objects insertObject:[_objects objectAtIndex:count-j-2] atIndex:j];
//        j++;
//    }
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
    [formate setDateStyle:NSDateFormatterMediumStyle];
    [formate setTimeStyle:NSDateFormatterMediumStyle];
    NSString *formateDateString = [formate stringFromDate:[_objects objectAtIndex:indexPath.row]];
    cell.textLabel.text=formateDateString;
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    HistoryDetailViewController *dest=segue.destinationViewController;
    dest.details=[[NSMutableDictionary alloc]init];
    NSInteger _selectedIndex=[self.tableView indexPathForSelectedRow].row;
    for (NSManagedObject *info in fetchObject) {
            if([[_objects objectAtIndex:_selectedIndex] isEqualToDate:[info valueForKey:@"time"]]&&[[info valueForKey:@"cwid"] isEqualToString:currentUser[@"CWID"]])
            {
                [dest.details setValue:[info valueForKey:@"state"] forKey:@"state"];
                [dest.details setValue:[info valueForKey:@"message"] forKey:@"message"];
                [dest.details setValue:[info valueForKey:@"from"] forKey:@"from"];
                [dest.details setValue:[info valueForKey:@"to"] forKey:@"to"];
                [dest.details setValue:[info valueForKey:@"number"] forKey:@"number"];
                [dest.details setValue:[info valueForKey:@"time"] forKey:@"time"];
                [dest.details setValue:[info valueForKey:@"car"] forKey:@"car"];
                [dest.details setValue:[info valueForKey:@"driver"] forKey:@"driver"];
            }
    }
}

@end
