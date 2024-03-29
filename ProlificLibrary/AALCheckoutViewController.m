//
//  AALCheckoutViewController.m
//  ProlificLibrary
//
//  Created by Albert Lardizabal on 9/4/14.
//  Copyright (c) 2014 Albert Lardizabal. All rights reserved.
//

#import "AALCheckoutViewController.h"
#import "AALBookDetailViewController.h"
#import "AALLibraryDataStore.h"

@interface AALCheckoutViewController ()

@property (nonatomic) AALLibraryDataStore *store;
@property (weak, nonatomic) IBOutlet UITextField *enterNameTextField;

- (IBAction)cancelButtonPressed:(id)sender;
- (IBAction)saveNameForCheckout:(id)sender;
- (IBAction)hideKeyboard:(id)sender;

@end

@implementation AALCheckoutViewController

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
    
    self.enterNameTextField.autocapitalizationType = UITextAutocapitalizationTypeWords;
    self.enterNameTextField.delegate = self;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)cancelButtonPressed:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)saveNameForCheckout:(id)sender
{
    
    if ([self.enterNameTextField.text isEqual:@""]) {
        
        UIAlertView *nameTextFieldBlankAlertView = [[UIAlertView alloc] initWithTitle:@"Missing Required Info"
                                                                              message:@"Please Enter Your Name"
                                                                             delegate:self
                                                                    cancelButtonTitle:@"OK"
                                                                    otherButtonTitles:nil];
        [nameTextFieldBlankAlertView show];
        
    } else {
        
        NSDate *currentDate = [NSDate date];
        
        [self.store checkoutLibraryBookWithName:self.enterNameTextField.text bookID:self.specificBookDetails.bookID checkoutDate:currentDate completion:^(BOOL success) {
            
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                
                self.specificBookDetails.lastCheckedOutBy = self.enterNameTextField.text;
                self.specificBookDetails.lastCheckedOutDate = currentDate;
                
                AALBookDetailViewController *bookDetailVC = [[AALBookDetailViewController alloc]init];
                bookDetailVC.specificBookDetails = self.specificBookDetails;
                
                [self dismissViewControllerAnimated:YES completion:nil];
                
            }];
        }];
    }
}

- (IBAction)hideKeyboard:(id)sender
{
    [self.enterNameTextField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
