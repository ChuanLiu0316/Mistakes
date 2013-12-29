//
//  SubjectCDTVC.h
//  Mistake Notebook
//
//  Created by ChuanLiu on 10/19/13.
//  Copyright (c) 2013 ChuanLiu. All rights reserved.
//

#import "CoreDataTableViewController.h"

@interface SubjectCDTVC : CoreDataTableViewController

@property (nonatomic,strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic,strong) NSString *answer;

@end
