//
//  Subject+add.h
//  Mistake Notebook
//
//  Created by ChuanLiu on 10/19/13.
//  Copyright (c) 2013 ChuanLiu. All rights reserved.
//

#import "Subject.h"

@interface Subject (add)

+(Subject *)addSubjectWithTitle: (NSString *)title
         inManagedObjectContext: (NSManagedObjectContext *)text;


@end
