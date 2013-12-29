//
//  AskerViewController.m
//  Mistake Notebook
//
//  Created by ChuanLiu on 10/19/13.
//  Copyright (c) 2013 ChuanLiu. All rights reserved.
//

#import "AskerViewController.h"


@interface AskerViewController ()


@property (weak, nonatomic) IBOutlet UILabel *questionLabel;
@property (weak, nonatomic) IBOutlet UITextField *answerTextField;

@end

@implementation AskerViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.questionLabel.text = @"What subject do you want to add";
    self.answerTextField.text = nil;
    [self.answerTextField becomeFirstResponder];
    
}

- (IBAction)enter:(id)sender {
    self.answer = self.answerTextField.text;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Enter" object:nil];
}

- (IBAction)cancel:(id)sender {
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Cancel" object:nil];
  
}


@end
