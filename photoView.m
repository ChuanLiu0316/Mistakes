//
//  photoView.m
//  Mistake Notebook
//
//  Created by ChuanLiu on 10/22/13.
//  Copyright (c) 2013 ChuanLiu. All rights reserved.
//

#import "photoView.h"

@implementation photoView

-(void)drawRect:(CGRect)rect
{
    

    [self.image drawInRect:self.bounds];
}
@end
