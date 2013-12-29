//
//  MistakesCVC.m
//  Mistake Notebook
//
//  Created by ChuanLiu on 10/20/13.
//  Copyright (c) 2013 ChuanLiu. All rights reserved.
//

#import "MistakesCVC.h"
#import "Mistake.h"
#import "MistakeCVCell.h"
#import "Mistake+add.h"
#import <MobileCoreServices/MobileCoreServices.h>
@interface MistakesCVC () <UICollectionViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *mistakeCollectionView;
@property (strong,nonatomic) NSArray *mistakes;
@property (strong,nonatomic) NSString *title;
@property (strong,nonatomic) UIImage *processingImage;


@end




@implementation MistakesCVC


- (IBAction)add:(UIBarButtonItem *)sender {
    [self presentImagePicker:UIImagePickerControllerSourceTypeCamera sender:sender];
}


-(void)presentImagePicker: (UIImagePickerControllerSourceType )sourcetype sender:(UIBarButtonItem *)button
{
    if([UIImagePickerController isSourceTypeAvailable:sourcetype])
    {
        NSArray *availableType = [UIImagePickerController availableMediaTypesForSourceType:sourcetype];
        if([availableType containsObject:(NSString *)kUTTypeImage])
        {
            UIImagePickerController *picker =[[UIImagePickerController alloc]init];
            picker.sourceType =sourcetype;
            picker.mediaTypes = @[(NSString *)kUTTypeImage];
            picker.allowsEditing = YES;
            picker.delegate = self;
            [self presentViewController:picker animated:YES completion:nil];
            
            
        }
            
    }
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = info[UIImagePickerControllerEditedImage];
    if(image)
    {
        image=info[UIImagePickerControllerOriginalImage];
    }
    
    UIImageOrientation orientation = image.imageOrientation;
    
    if (orientation != UIImageOrientationUp) {
        UIGraphicsBeginImageContext(image.size);
        [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
    }
    
    self.processingImage = image;
    [self dismissViewControllerAnimated:YES completion:^{  [self performSegueWithIdentifier:@"create" sender:self];}];
    
}


-(void)viewDidLoad
{
    [super viewDidLoad];
   
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(create)
                                                 name:@"create" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(cancel)
                                                 name:@"cancel" object:nil];
   
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(deleteMistake)
                                                 name:@"Delete"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(cancelAnswer) name:@"CancelAnswer"
                                               object:nil];
}

-(void) cancelAnswer
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) deleteMistake
{
   Mistake *mistakedelete =  [self.presentedViewController performSelector:@selector(mistake)];
    [self dismissViewControllerAnimated:YES completion:^{
        
        NSURL *urldelete = [NSURL URLWithString:mistakedelete.imageUrl];
        NSError *error= nil;
        [[NSFileManager defaultManager] removeItemAtURL:urldelete error:&error];
        NSNumber *number = mistakedelete.number;
        int integer = [number intValue];
        [self.subject.managedObjectContext deleteObject:mistakedelete];
        for (int i = integer+1; i<=[self.mistakes count]; i++)
        {
            for (Mistake *mistake in self.mistakes)
            {
                
                
                if ([mistake.number intValue] == i) {
                    mistake.number = [NSNumber numberWithInt:[mistake.number intValue]-1];
                    
                    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:mistake.imageUrl]];
                    
                    
                    NSString *temp = [self.subject.title stringByAppendingString:[NSString stringWithFormat:@" %lu",((unsigned long)[mistake.number intValue])]];
                    NSURL *url = [[[NSFileManager defaultManager]URLsForDirectory:NSDocumentDirectory
                                                                        inDomains:NSUserDomainMask] lastObject];
                    
                    
                    url = [url URLByAppendingPathComponent:temp];
                    temp = [url absoluteString];
                    
                    
                    
                    [data writeToURL:url atomically:YES];
                    mistake.imageUrl =temp;
                }
            }
        }
        
        [self updateMistake];
        [self.mistakeCollectionView reloadData];
       
        
        
    }];
    
   
}

-(void) create
{;
    
    NSString *answer = [self.presentedViewController performSelector:@selector(answer)];
    
    UIImage *image = [self.presentedViewController performSelector:@selector(image)];
 
    
    [self dismissViewControllerAnimated:YES completion:^{
        
        
    
        
        NSData *imageData = UIImagePNGRepresentation(image);
        
        
        NSNumber *number =[NSNumber numberWithInteger:[self.mistakes count]];
        NSURL *url = [[[NSFileManager defaultManager]URLsForDirectory:NSDocumentDirectory
                                                            inDomains:NSUserDomainMask] lastObject];
        NSString *temp = [self.subject.title stringByAppendingString:[NSString stringWithFormat:@" %lu",((unsigned long)[self.mistakes count])]];
        
        url = [url URLByAppendingPathComponent:temp];
        temp = [url absoluteString];
        
        
        
        [imageData writeToURL:url atomically:YES];
        [self addMistakewithUrl:temp answer:answer number:number];
        [self.mistakeCollectionView reloadData];
        
    }];
    
    
}

-(void) cancel
{
    
    [self dismissViewControllerAnimated:YES completion:^{}];
}

-(void) addMistakewithUrl: (NSString *)url answer: (NSString *)answer number:(NSNumber *)number
{
    
    [Mistake addMistakeofSubject:self.subject url:url answer:answer number:number inManagedObjectContext:self.subject.managedObjectContext];
   
    [self updateMistake];
    
}
-(void)setMistakes:(NSArray *)mistakes{
    
    _mistakes = mistakes;
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.title = self.subject.title;
     [self updateMistake];
}

-(void)setSubject:(Subject *)subject
{
   
    _subject = subject;
   
}

-(void)updateMistake
{
    NSError *error;
   
    
   
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Mistake"];
        
    request.predicate = [NSPredicate predicateWithFormat:@"whichSubject = %@", self.subject];
    NSArray *mistakes =  [self.subject.managedObjectContext executeFetchRequest:request error:&error];
    
    self.mistakes = mistakes;
    
                        
                     
}



-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}



-(NSInteger)collectionView:(UICollectionView *)collectionView
    numberOfItemsInSection:(NSInteger)section
{
    return [self.mistakes count];
   
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    UICollectionViewCell *cell =[self.mistakeCollectionView dequeueReusableCellWithReuseIdentifier:@"Mistake" forIndexPath:indexPath];
    
    
        MistakeView *mistakeView = ((MistakeCVCell *)cell).mistakeView;
        mistakeView.mistake = self.mistakes[indexPath.item];
        
        
    
    return  cell;
}



-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"Answer"])
    {
        NSIndexPath *indexpath = [self.mistakeCollectionView indexPathForCell:sender];
        [segue.destinationViewController performSelector:@selector(setMistake:) withObject:self.mistakes[indexpath.item]];
    }
    if ([segue.identifier isEqualToString:@"create"])
    {
        [segue.destinationViewController performSelector:@selector(setImage:) withObject:self.processingImage];
    }
}
@end
