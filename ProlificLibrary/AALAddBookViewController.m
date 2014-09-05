//
//  AALAddBookViewController.m
//  ProlificLibrary
//
//  Created by Albert Lardizabal on 9/2/14.
//  Copyright (c) 2014 Albert Lardizabal. All rights reserved.
//

#import "AALAddBookViewController.h"
#import "AALLibraryDataStore.h"

#define kOFFSET_FOR_KEYBOARD 200.0

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

// Methods to animate the view due to keyboard input
- (void)keyboardWillShow;
- (void)keyboardWillHide;

- (IBAction)doneButtonPressed:(id)sender;
- (IBAction)submitButtonPressed:(id)sender;
- (IBAction)hideKeyboard:(id)sender;

@end

@implementation AALAddBookViewController

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
    
}

#pragma mark - Adjust view for keyboard input methods

- (void)keyboardWillShow {
    
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
    
}

- (void)keyboardWillHide {
    
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
    
}

- (void)textFieldDidBeginEditing:(UITextField *)sender
{
    if  (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
}

- (void)setViewMovedUp:(BOOL)movedUp
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    
    CGRect rect = self.view.frame;
    
    if (movedUp)
    {
        rect.origin.y -= kOFFSET_FOR_KEYBOARD;
        rect.size.height += kOFFSET_FOR_KEYBOARD;
    }
    else
    {
        rect.origin.y += kOFFSET_FOR_KEYBOARD;
        rect.size.height -= kOFFSET_FOR_KEYBOARD;
    }
    self.view.frame = rect;
    
    [UIView commitAnimations];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
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
        
        [self.submitButtonAlertView show];
        
    } else {
        
        // Avoid a strong reference cycle by using "weak" self
        
        __weak AALAddBookViewController *addBookVC = self;
        
        [self.store addLibraryBookWithTitle:self.bookTitleTextField.text
                                     author:self.authorTextField.text
                                 categories:self.categoriesTextField.text
                                  publisher:self.publisherTextField.text
                                 completion:^(BOOL success) {
                                     
                                     [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                                         
                                         UIAlertView *bookSubmittedAlertView = [[UIAlertView alloc] initWithTitle:@"Success"
                                                                                                          message:@"You have just added a new book!"
                                                                                                         delegate:nil
                                                                                                cancelButtonTitle:@"OK"
                                                                                                otherButtonTitles:nil];
                                         [bookSubmittedAlertView show];
                                         
                                         addBookVC.bookTitleTextField.text = @"";
                                         addBookVC.authorTextField.text = @"";
                                         addBookVC.categoriesTextField.text = @"";
                                         addBookVC.publisherTextField.text = @"";
                                         
                                     }];
                                     
                                 }];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (alertView.tag == 0 && buttonIndex == 1)
    {
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }
    
}

- (IBAction)hideKeyboard:(id)sender
{
    [self.bookTitleTextField resignFirstResponder];
    [self.authorTextField resignFirstResponder];
    [self.publisherTextField resignFirstResponder];
    [self.categoriesTextField resignFirstResponder];
}

@end
