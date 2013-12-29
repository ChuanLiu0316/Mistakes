//
//  SubjectCDTVC.m
//  Mistake Notebook
//
//  Created by ChuanLiu on 10/19/13.
//  Copyright (c) 2013 ChuanLiu. All rights reserved.
//

#import "SubjectCDTVC.h"
#import "Subject+add.h"
#import "AskerViewController.h"
#import "Mistake+add.h"

@interface SubjectCDTVC ()
@property (nonatomic,strong) AskerViewController *asker;
@property (nonatomic,strong) Subject *subject;

@end

@implementation SubjectCDTVC

- (IBAction)Delete:(id)sender {
    
    

    for (UITableViewCell *cell in self.tableView.visibleCells)
    {
        if(cell.isSelected)
        {
             [self.managedObjectContext performBlock:^{
                 NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
                 Subject *subject= [self.fetchedResultsController objectAtIndexPath:indexPath];
                 [self.managedObjectContext deleteObject:subject];
                 
             }];
        }
        
    }
}

-(void)setAnswer:(NSString *)answer
{
    _answer = answer;
}

-(void) addSubjectofTitle: (NSString *)title
{
    [self.managedObjectContext performBlock:^{
        [Subject addSubjectWithTitle:title inManagedObjectContext:self.managedObjectContext];
    }];

}


-(void)viewDidLoad
{

    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                              selector:@selector(enter)
                                                 name:@"Enter" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(dismiss) name:@"Cancel"
                                               object:nil];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if(!self.managedObjectContext)[self useDocument];
    
}

-(void) dismiss
{
     [self dismissViewControllerAnimated:YES completion:^{
         
     }];
    
}

-(void) enter
{
    self.answer = [self.presentedViewController performSelector:@selector(answer)];
    
    [self dismissViewControllerAnimated:YES completion:^{
      
    [self addSubjectofTitle:self.answer];
    }];
}

-(void) useDocument
{
    NSURL *url = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    url = [url URLByAppendingPathComponent:@"MistakeNotebook"];
    UIManagedDocument *document = [[UIManagedDocument alloc] initWithFileURL:url];
    
    if(![[NSFileManager defaultManager] fileExistsAtPath:[url path]])
    {
        [document saveToURL:url
           forSaveOperation:UIDocumentSaveForCreating
          completionHandler:^(BOOL success) {
              self.managedObjectContext = document.managedObjectContext;}];
          [self addSubjectofTitle:@"sucess"];
    }
    
    else if(document.documentState == UIDocumentStateClosed)
    {
        [document openWithCompletionHandler:^(BOOL success) {
            self.managedObjectContext = document.managedObjectContext;
        }];
    }
    else
    {
        self.managedObjectContext = document.managedObjectContext;
    }
}

-(void)setManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    _managedObjectContext = managedObjectContext;
    
    if(managedObjectContext)
    {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Subject"];
        request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"title"
                                                                  ascending:YES
                                                                   selector:@selector(localizedCaseInsensitiveCompare:)]];
        request.predicate = nil; //all Subjects
        self.fetchedResultsController = [[NSFetchedResultsController alloc]initWithFetchRequest:request
                                                                           managedObjectContext:managedObjectContext
                                                                             sectionNameKeyPath:nil cacheName:nil];
        
    }
    else
    {
        self.fetchedResultsController = nil;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Subject"];
    
    Subject *subject = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = subject.title;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%lu mistakes", ((unsigned long)[subject.mistakes count])];
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"setSubject"])
    {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        Subject *subject = [self.fetchedResultsController objectAtIndexPath:indexPath];
        [segue.destinationViewController performSelector:@selector(setSubject:) withObject:subject];
       
        
    }
}

@end
