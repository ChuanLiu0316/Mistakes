//
//  CreateMistakeVC.m
//  Mistake Notebook
//
//  Created by ChuanLiu on 10/22/13.
//  Copyright (c) 2013 ChuanLiu. All rights reserved.
//

#import "CreateMistakeVC.h"
#import "photoView.h"
@interface CreateMistakeVC ()
@property (weak, nonatomic) IBOutlet UITextField *answerTextField;
@property (weak, nonatomic) IBOutlet photoView *photoview;


@end

@implementation CreateMistakeVC

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
  
    
    
    
    
}


-(void)viewDidLoad
{
    
    [super viewDidLoad];
       self.photoview.image = self.image;
  
}

- (IBAction)create:(id)sender {
    
        self.answer = self.answerTextField.text;
    if (self.answer.length>0) {
         [[NSNotificationCenter defaultCenter] postNotificationName:@"create" object:nil];
    }
    
    
   
}

- (IBAction)cancel:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"cancel" object:nil];
}


@end
