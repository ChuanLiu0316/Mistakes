//
//  Subject.h
//  Mistake Notebook
//
//  Created by ChuanLiu on 10/24/13.
//  Copyright (c) 2013 ChuanLiu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Mistake;

@interface Subject : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSSet *mistakes;
@end

@interface Subject (CoreDataGeneratedAccessors)

- (void)addMistakesObject:(Mistake *)value;
- (void)removeMistakesObject:(Mistake *)value;
- (void)addMistakes:(NSSet *)values;
- (void)removeMistakes:(NSSet *)values;

@end
