//
//  Subject+add.m
//  Mistake Notebook
//
//  Created by ChuanLiu on 10/19/13.
//  Copyright (c) 2013 ChuanLiu. All rights reserved.
//

#import "Subject+add.h"

@implementation Subject (add)

+(Subject *)addSubjectWithTitle:(NSString *)title
         inManagedObjectContext:(NSManagedObjectContext *)text
{
    Subject *subject = nil;
    
    subject = [NSEntityDescription insertNewObjectForEntityForName:@"Subject"
                                            inManagedObjectContext:text];
    subject.title = title;
    
    return  subject;
}

@end
