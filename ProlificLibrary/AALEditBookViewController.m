//
//  AALEditBookViewController.m
//  ProlificLibrary
//
//  Created by Albert Lardizabal on 9/4/14.
//  Copyright (c) 2014 Albert Lardizabal. All rights reserved.
//
//  viewWillAppear will add the keyboard hide/show notifications
//  depending on the state, the keyboardWillShow or keyboardWillHide methods will run
//  setViewMovedUp will shift the main view's frame and add/remove whitespace for the keyboard

#import "AALEditBookViewController.h"
#import "AALBookDetailViewController.h"
#import "AALLibraryDataStore.h"

#define kOFFSET_FOR_KEYBOARD 220.0

@interface AALEditBookViewController ()

@property (nonatomic) AALLibraryDataStore *store;

@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *authorTextField;
@property (weak, nonatomic) IBOutlet UITextField *publisherTextField;
@property (weak, nonatomic) IBOutlet UITextField *tagsTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastCheckedOutByTextField;

// Methods to animate the view due to keyboard input
- (void)keyboardWillShow;
- (void)keyboardWillHide;

- (IBAction)cancelButtonPressed:(id)sender;
- (IBAction)saveButtonPressed:(id)sender;
- (IBAction)hideKeyboard:(id)sender;

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
    self.tagsTextField.text = self.specificBookDetails.categories;
    self.lastCheckedOutByTextField.text = self.specificBookDetails.lastCheckedOutBy;
    
    self.titleTextField.autocapitalizationType = UITextAutocapitalizationTypeWords;
    self.authorTextField.autocapitalizationType = UITextAutocapitalizationTypeWords;
    self.publisherTextField.autocapitalizationType = UITextAutocapitalizationTypeWords;
    self.lastCheckedOutByTextField.autocapitalizationType = UITextAutocapitalizationTypeWords;
    
    self.titleTextField.delegate = self;
    self.authorTextField.delegate = self;
    self.publisherTextField.delegate = self;
    self.tagsTextField.delegate = self;
    self.lastCheckedOutByTextField.delegate = self;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Adjust view for keyboard input methods

- (void)keyboardWillShow {
    
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
}

- (void)keyboardWillHide {
    
    // If the keyboard is about to hide, check the frame if the y origin is less than zero.  If yes, then
    // call setViewMovedUp and push the view down and remove the whitespace for the keyboard.
    
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
                                        self.specificBookDetails.categories = self.tagsTextField.text;
                                        
                                        self.specificBookDetails.lastCheckedOutBy = self.lastCheckedOutByTextField.text;
                                        
                                        AALBookDetailViewController *bookDetailVC = [[AALBookDetailViewController alloc]init];
                                        bookDetailVC.specificBookDetails = self.specificBookDetails;
                                        
                                        [self dismissViewControllerAnimated:YES completion:nil];
                                        
                                    }];
                                }];
}

- (IBAction)hideKeyboard:(id)sender
{
    [self.titleTextField resignFirstResponder];
    [self.authorTextField resignFirstResponder];
    [self.publisherTextField resignFirstResponder];
    [self.tagsTextField resignFirstResponder];
    [self.lastCheckedOutByTextField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
