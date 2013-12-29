//
//  Mistake.h
//  Mistake Notebook
//
//  Created by ChuanLiu on 10/24/13.
//  Copyright (c) 2013 ChuanLiu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Subject;

@interface Mistake : NSManagedObject

@property (nonatomic, retain) NSString * answer;
@property (nonatomic, retain) NSString * imageUrl;
@property (nonatomic, retain) NSNumber * number;
@property (nonatomic, retain) Subject *whichSubject;

@end
