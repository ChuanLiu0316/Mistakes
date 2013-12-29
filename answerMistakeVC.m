//
//  AnswerMistakeVC.m
//  Mistake Notebook
//
//  Created by ChuanLiu on 10/22/13.
//  Copyright (c) 2013 ChuanLiu. All rights reserved.
//

#import "AnswerMistakeVC.h"
#import "MistakeView.h"

@interface AnswerMistakeVC ()
@property (weak, nonatomic) IBOutlet UITextField *AnswerTextField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *button;
@property (weak, nonatomic) IBOutlet UILabel *AnswerLabel;
@property (weak, nonatomic) IBOutlet MistakeView *mistakeView;

@end


@implementation AnswerMistakeVC

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.mistakeView.mistake = self.mistake;
}

- (IBAction)cancel:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CancelAnswer" object:nil];
}

- (IBAction)done:(id)sender {
    if ((self.AnswerTextField.text.length >0)&&(!self.AnswerLabel.text))
    {
        
        if ([self.AnswerTextField.text isEqualToString:self.mistake.answer])
        {
            self.AnswerLabel.text = [NSString stringWithFormat:@"Yes!"];
            self.button.title = @"Delete";
            
        }
        else
        {
            self.AnswerLabel.text = [NSString stringWithFormat:@"Wrong!"];
            self.button.title =@"Check Answer";
        }
        
    }
    else
    {
        
         if([self.button.title isEqualToString:@"Delete"])
         {
         [[NSNotificationCenter defaultCenter] postNotificationName:@"Delete" object:nil];
         }
    
         if([self.button.title isEqualToString:@"Check Answer"])
         {
         self.AnswerLabel.text = self.mistake.answer;
         }
    }
    
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.AnswerLabel.text = nil;
}
        
@end
