//
//  Mistake+add.h
//  Mistake Notebook
//
//  Created by ChuanLiu on 10/19/13.
//  Copyright (c) 2013 ChuanLiu. All rights reserved.
//

#import "Mistake.h"

@interface Mistake (add)

+(Mistake *) addMistakeofSubject: (Subject *)subject
                             url: (NSString *)url
                          answer: (NSString *)answer
                          number: (NSNumber *)number
          inManagedObjectContext: (NSManagedObjectContext *)text;


@end
