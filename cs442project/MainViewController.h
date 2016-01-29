//
//  MainViewController.h
//  cs442project
//
//  Created by Zeyu Li on 3/31/14.
//  Copyright (c) 2014 Zeyu Li. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <Parse/Parse.h>

@interface MainViewController : UIViewController<CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet UIBarButtonItem * sidebarButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *barButon;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
@property (strong, nonatomic) IBOutlet MKMapView *myMapView;
@property (strong,nonatomic)NSManagedObjectContext *context;
@property (strong,nonatomic)NSManagedObjectContext *context2;
@end
