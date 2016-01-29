//
//  Review.h
//  cs442project
//
//  Created by Xiaoyang Lu on 4/27/14.
//  Copyright (c) 2014 Xiaoyang Lu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Review : NSManagedObject

@property (nonatomic, retain) NSString * cwid;
@property (nonatomic, retain) NSString * category;
@property (nonatomic, retain) NSString * part;
@property (nonatomic, retain) NSDate * time;
@property (nonatomic, retain) NSString * review;

@end
