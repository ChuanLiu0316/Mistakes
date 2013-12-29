//
//  Mistake+add.m
//  Mistake Notebook
//
//  Created by ChuanLiu on 10/19/13.
//  Copyright (c) 2013 ChuanLiu. All rights reserved.
//

#import "Mistake+add.h"

@implementation Mistake (add)


+(Mistake *)addMistakeofSubject:(Subject *)subject
                            url:(NSString *)url
                         answer:(NSString *)answer
                         number:(NSNumber *)number
         inManagedObjectContext:(NSManagedObjectContext *)text
{
    Mistake *mistake = nil;
    mistake = [NSEntityDescription insertNewObjectForEntityForName:@"Mistake"
                                            inManagedObjectContext:text];
    
    mistake.imageUrl = url;
    mistake.answer = answer;
    mistake.whichSubject = subject;
    mistake.number = number;
    
    
    return mistake;
}

@end
