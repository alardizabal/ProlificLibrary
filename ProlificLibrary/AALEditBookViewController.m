//
//  AALEditBookViewController.m
//  ProlificLibrary
//
//  Created by Albert Lardizabal on 9/4/14.
//  Copyright (c) 2014 Albert Lardizabal. All rights reserved.
//

#import "AALEditBookViewController.h"
#import "AALBookDetailViewController.h"
#import "AALLibraryDataStore.h"

@interface AALEditBookViewController ()

@property (nonatomic) AALLibraryDataStore *store;

@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *authorTextField;
@property (weak, nonatomic) IBOutlet UITextField *publisherTextField;
@property (weak, nonatomic) IBOutlet UITextField *tagsTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastCheckedOutByTextField;

@end

@implementation AALEditBookViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.store = [AALLibraryDataStore sharedDataStore];
    
    self.titleTextField.text = self.specificBookDetails.title;
    self.authorTextField.text = self.specificBookDetails.author;
    self.publisherTextField.text = self.specificBookDetails.publisher;
    self.tagsTextField.text = [NSString stringWithFormat:@"%@", [self.specificBookDetails.categories componentsJoinedByString:@","]];
    self.lastCheckedOutByTextField.text = self.specificBookDetails.lastCheckedOutBy;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)cancelButtonPressed:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)saveButtonPressed:(id)sender
{
    [self.store updateLibraryBookWithTitle:self.titleTextField.text
                                    author:self.authorTextField.text
                                    bookID:self.specificBookDetails.bookID
                                categories:self.tagsTextField.text
                                 publisher:self.publisherTextField.text
                          lastCheckedOutBy:self.lastCheckedOutByTextField.text
                                completion:^(BOOL success) {
                                    
                                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                        
                                        self.specificBookDetails.title = self.titleTextField.text;
                                        self.specificBookDetails.author = self.authorTextField.text;
                                        self.specificBookDetails.publisher = self.publisherTextField.text;
                                        //self.specificBookDetails.categories = self.tagsTextField.text;
                                        self.specificBookDetails.lastCheckedOutBy = self.lastCheckedOutByTextField.text;
                                        
                                        AALBookDetailViewController *bookDetailVC = [[AALBookDetailViewController alloc]init];
                                        bookDetailVC.self.specificBookDetails = self.specificBookDetails;
                                        
                                        [self dismissViewControllerAnimated:YES completion:nil];
                                        
                                    }];
                                }];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
