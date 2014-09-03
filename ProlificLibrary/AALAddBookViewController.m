//
//  AALAddBookViewController.m
//  ProlificLibrary
//
//  Created by Albert Lardizabal on 9/2/14.
//  Copyright (c) 2014 Albert Lardizabal. All rights reserved.
//

#import "AALAddBookViewController.h"
#import "AALLibraryDataStore.h"

@interface AALAddBookViewController ()

@property (nonatomic) AALLibraryDataStore *store;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;
@property (weak, nonatomic) IBOutlet UITextField *bookTitleTextField;
@property (weak, nonatomic) IBOutlet UITextField *authorTextField;
@property (weak, nonatomic) IBOutlet UITextField *publisherTextField;
@property (weak, nonatomic) IBOutlet UITextField *categoriesTextField;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;

@property (nonatomic) UIAlertView *doneButtonAlertView;
@property (nonatomic) UIAlertView *submitButtonAlertView;

@end

@implementation AALAddBookViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.store = [AALLibraryDataStore sharedDataStore];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)doneButtonPressed:(id)sender
{
    if (self.bookTitleTextField.text || self.authorTextField.text || self.publisherTextField.text || self.categoriesTextField.text) {
        
        self.doneButtonAlertView = [[UIAlertView alloc] initWithTitle:@"Warning!"
                                                          message:@"You have unsaved changes.\n  Click OK to discard edits."
                                                         delegate:self
                                                cancelButtonTitle:@"Cancel"
                                                otherButtonTitles:@"OK", nil];
        self.doneButtonAlertView.delegate = self;
        self.doneButtonAlertView.tag = 0;
        [self.doneButtonAlertView show];
    }
}

- (IBAction)submitButtonPressed:(id)sender
{
    
    if ([self.bookTitleTextField.text isEqualToString:@""] || [self.authorTextField.text isEqualToString:@""])
    {
        self.submitButtonAlertView = [[UIAlertView alloc] initWithTitle:@"Missing Required Info"
                                                          message:@"Title and author fields \n must be populated!"
                                                         delegate:self
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];
        self.submitButtonAlertView.delegate = self;
        self.submitButtonAlertView.tag = 1;
        [self.submitButtonAlertView show];
        
    } else {
        
        [self.store addLibraryBookWithTitle:self.bookTitleTextField.text
                                     author:self.authorTextField.text
                                 categories:self.categoriesTextField.text
                                  publisher:self.publisherTextField.text
                                 completion:^(BOOL success) {
                                 }];
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (alertView.tag == 0 && buttonIndex == 1)
    {
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }
    
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
