//
//  MistakeView.m
//  Mistake Notebook
//
//  Created by ChuanLiu on 10/20/13.
//  Copyright (c) 2013 ChuanLiu. All rights reserved.
//

#import "MistakeView.h"

@implementation MistakeView

#define CORNER_RADIUS 12.0

-(void)drawRect:(CGRect)rect
{
    
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:CORNER_RADIUS];
    
    [roundedRect addClip];
    
    [[UIColor whiteColor] setFill];
    UIRectFill(self.bounds);

    
   NSURL *url =  [NSURL URLWithString:self.mistake.imageUrl];
    NSData *imageData = [[NSData alloc]initWithContentsOfURL:url];
     UIImage *image =  [UIImage imageWithData:imageData];
     [image drawInRect:self.bounds];
    
    [[UIColor blackColor] setStroke];
    [roundedRect stroke];
}
