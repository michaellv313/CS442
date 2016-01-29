//
//  YourDetailReviewsViewController.m
//  cs442project
//
//  Created by Xiaoyang Lu on 4/1/14.
//  Copyright (c) 2014 Xiaoyang Lu. All rights reserved.
//

#import "YourDetailReviewsViewController.h"
#import "Review.h"
#import "AppDelegate.h"

@interface YourDetailReviewsViewController ()

@end

@implementation YourDetailReviewsViewController
{
    UILabel *time;
    UILabel *category;
    UILabel *part;
    UITextView *review;
    NSDate *timeContent;
    NSString *cateContent;
    NSString *partContent;
    NSString *reviewContent;
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
    self.title=@"Review Details";
    self.navigationController.navigationBar.topItem.title = @"";
    self.tableView.separatorStyle = NO;
    _menuItems = @[@"time", @"category", @"part", @"review"];
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    self.context = delegate.managedObjectContext;
    NSError *error = nil;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Review"inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSArray *fetchObject = [context executeFetchRequest:fetchRequest error:&error];
    for (NSManagedObject *info in fetchObject) {
        PFUser *currentUser = [PFUser currentUser];
        if([[info valueForKey:@"cwid"] isEqualToString:currentUser[@"CWID"]]&&[self.date isEqualToDate:[info valueForKey:@"time"]])
        {
            timeContent = [info valueForKey:@"time"];
            cateContent = [info valueForKey:@"category"];
            partContent = [info valueForKey:@"part"];
            reviewContent=[info valueForKey:@"review"];
        }
    }
	// Do any additional setup after loading the view.
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
        time = (UILabel*)[cell.contentView viewWithTag:1];
        NSDateFormatter *formate = [[NSDateFormatter alloc] init];
        [formate setDateStyle:NSDateFormatterMediumStyle];
        [formate setTimeStyle:NSDateFormatterMediumStyle];
        NSString *formateDateString = [formate stringFromDate:timeContent];
        time.text = formateDateString;
    }
    if([cell.contentView viewWithTag:2])
    {
        category = (UILabel*)[cell.contentView viewWithTag:2];
        category.text=cateContent;
    }
    if([cell.contentView viewWithTag:3])
    {
        part = (UILabel*)[cell.contentView viewWithTag:3];
        part.text=partContent;
    }
    if([cell.contentView viewWithTag:4])
    {
        review = (UITextView*)[cell.contentView viewWithTag:4];
        [review.layer setBorderWidth:1];
        [review.layer setCornerRadius:10];
        review.text=reviewContent;
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 3)
        return 245;
    return 50;
}

@end
