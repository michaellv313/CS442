//
//  Request.h
//  cs442project
//
//  Created by Xiaoyang Lu on 4/25/14.
//  Copyright (c) 2014 Xiaoyang Lu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Request : NSManagedObject

@property (nonatomic, retain) NSString * cwid;
@property (nonatomic, retain) NSString * from;
@property (nonatomic, retain) NSString * to;
@property (nonatomic, retain) NSNumber * number;
@property (nonatomic, retain) NSDate * time;
@property (nonatomic, retain) NSNumber * car;
@property (nonatomic, retain) NSString * driver;
@property (nonatomic, retain) NSString * state;
@property (nonatomic, retain) NSString * message;

@end
