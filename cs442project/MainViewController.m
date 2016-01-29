//
//  MainViewController.m
//  cs442project
//
//  Created by Xiaoyang Lu on 3/31/14.
//  Copyright (c) 2014 Xiaoyang Lu. All rights reserved.
//

#import "MainViewController.h"
#import "SWRevealViewController.h"
#import "Review.h"
#import "Request.h"
#import "AppDelegate.h"

@interface MainViewController ()

@end

@implementation MainViewController
{
    CLLocationManager *locationManager;
}

@synthesize sidebarButton=_sidebarButton;
@synthesize myMapView;
@synthesize context;
@synthesize context2;

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
    self.title = @"IIT Services";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"Helvetica-Bold" size:18.0],
                                                                     NSForegroundColorAttributeName: [UIColor whiteColor]}];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbar.png"] forBarMetrics:UIBarMetricsDefault];
    [self.toolbar setBackgroundImage:[UIImage imageNamed:@"navigationbar.png"] forToolbarPosition:0 barMetrics:0];
    [self.barButon setTitleTextAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"Helvetica-Bold" size:18.0]} forState:UIControlStateNormal];
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    self.view.backgroundColor = [UIColor whiteColor];
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    // MapView
    self.myMapView.showsUserLocation = YES;
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate=self;
    locationManager.desiredAccuracy=kCLLocationAccuracyBest;
    locationManager.distanceFilter=1000.0f;
    [locationManager startUpdatingLocation];
    CLLocationCoordinate2D coords = CLLocationCoordinate2DMake(41.878114,-87.629798);
    MKCoordinateRegion region= MKCoordinateRegionMake(coords, MKCoordinateSpanMake(0.05, 0.05));;
    [myMapView setRegion:[myMapView regionThatFits:region] animated:YES];
    
    PFUser *currentUser = [PFUser currentUser];
    //coreData for Review
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    self.context = delegate.managedObjectContext;
    NSError *error = nil;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Review"inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSArray *fetchObject = [context executeFetchRequest:fetchRequest error:&error];

    int i=0;
    for (NSManagedObject *info in fetchObject) {
        if([[info valueForKey:@"cwid"] isEqualToString:currentUser[@"CWID"]])
        {
            i++;
        }
    }
    if(i==0){
    PFQuery *query = [PFQuery queryWithClassName:@"Review"];
    [query whereKey:@"CWID" equalTo:currentUser[@"CWID"]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (PFObject *object in objects) {
                Review *coreData = [NSEntityDescription insertNewObjectForEntityForName:@"Review" inManagedObjectContext:context];
                coreData.cwid=object[@"CWID"];
                coreData.category=object[@"category"];
                coreData.part=object[@"part"];
                coreData.time=object[@"time"];
                coreData.review=object[@"review"];
                NSError *error = nil;
                if (![context save:&error]) {
                    NSLog(@"%@",[error localizedDescription]);
                }
            }
        }
    }];
    }
    //coredata for request
    self.context2 = delegate.managedObjectContext;
    NSFetchRequest *fetchRequest2 = [[NSFetchRequest alloc]init];
    NSEntityDescription *entity2 = [NSEntityDescription entityForName:@"Request"inManagedObjectContext:context];
    [fetchRequest2 setEntity:entity2];
    NSArray *fetchObject2 = [context executeFetchRequest:fetchRequest2 error:&error];
    int j=0;
    for (NSManagedObject *info in fetchObject2) {
        if([[info valueForKey:@"cwid"] isEqualToString:currentUser[@"CWID"]])
        {
            j++;
        }
    }
    PFQuery *query4 = [PFQuery queryWithClassName:@"Request"];
    [query4 whereKey:@"CWID" equalTo:currentUser[@"CWID"]];
    [query4 findObjectsInBackgroundWithBlock:^(NSArray *objects4, NSError *error) {
    if(j!=objects4.count)
    {
        PFQuery *query1 = [PFQuery queryWithClassName:@"Request"];
        [query1 whereKey:@"CWID" equalTo:currentUser[@"CWID"]];
        [query1 findObjectsInBackgroundWithBlock:^(NSArray *objects1, NSError *error) {
            if (!error) {
                for (PFObject *object1 in objects1) {
                    Request *coreData2 = [NSEntityDescription insertNewObjectForEntityForName:@"Request" inManagedObjectContext:context2];
                    coreData2.cwid=object1[@"CWID"];
                    coreData2.from=object1[@"currentlocation"];
                    coreData2.to=object1[@"destination"];
                    coreData2.number=object1[@"numberofpeople"];
                    coreData2.time=object1[@"time"];
                    if([object1[@"state"]isEqualToString:@"arrived"]||[object1[@"state"]isEqualToString:@"canceled"]||[object1[@"state"]isEqualToString:@"accepted"])
                    {
                        if([object1[@"state"]isEqualToString:@"accepted"])
                        {
                            coreData2.state=@"Accepted";
                            coreData2.message=@"Wait your car";
                        }
                        if([object1[@"state"]isEqualToString:@"arrived"])
                        {
                            coreData2.state=@"Arrived";
                            coreData2.message=@"Thanks";
                        }
                        if([object1[@"state"]isEqualToString:@"canceled"])
                        {
                            coreData2.state=@"Canceled";
                            coreData2.message=@"Please reserve again";
                        }
                        PFQuery *query2 = [PFQuery queryWithClassName:@"mapping"];
                        [query2 whereKey:@"CWID" equalTo:currentUser[@"CWID"]];
                        //NSLog(@"%@",currentUser[@"CWID"]);
                        [query2 whereKey:@"time" equalTo:object1[@"time"]];
                        //NSLog(@"%@",object1[@"time"]);
                        [query2 findObjectsInBackgroundWithBlock:^(NSArray *objects2, NSError *error) {
                            if(!error)
                            {
                                for (PFObject *object2 in objects2) {
                                    coreData2.car=object2[@"carNumber"];
                                    //NSLog(@"%@",object2[@"carNumber"]);
                                    PFQuery *query3 = [PFQuery queryWithClassName:@"Cars"];
                                    [query3 whereKey:@"carNumber" equalTo:object2[@"carNumber"]];
                                    [query3 whereKey:@"driver" notEqualTo:@"Test"];
                                    [query3 findObjectsInBackgroundWithBlock:^(NSArray *objects3, NSError *error) {
                                        if(!error)
                                        {
                                            for (PFObject *object3 in objects3) {
                                                coreData2.driver=object3[@"driver"];
                                            }
                                        }
                                    }];

                                }
                            }
                        }];
                    }
                    else{
                        coreData2.car=@99999999;
                        coreData2.driver=@"Not Availble";
                    }
                    NSError *error = nil;
                    if (![context2 save:&error]) {
                        NSLog(@"%@",[error localizedDescription]);
                    }
                }
            }
        }];

    }
    }];
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    [locationManager stopUpdatingLocation];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
