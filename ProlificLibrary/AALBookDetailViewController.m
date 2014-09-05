//
//  AALBookDetailViewController.m
//  ProlificLibrary
//
//  Created by Albert Lardizabal on 9/2/14.
//  Copyright (c) 2014 Albert Lardizabal. All rights reserved.
//

#import "AALBookDetailViewController.h"
#import "AALEditBookViewController.h"
#import "AALCheckoutViewController.h"
#import "AALConstants.h"

@interface AALBookDetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *bookTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *publisherLabel;
@property (weak, nonatomic) IBOutlet UILabel *tagsLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastCheckedOutByLabel;

@property (weak, nonatomic) IBOutlet UIButton *checkoutButton;
@property (weak, nonatomic) IBOutlet UIButton *editButton;

- (IBAction)shareButtonPressed:(id)sender;

@end

@implementation AALBookDetailViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated
{

    if (self.specificBookDetails.title == (id)[NSNull null]) {
        self.specificBookDetails.title = @"Title N/A";
        
    } else if (self.specificBookDetails.author == (id)[NSNull null]) {
        self.specificBookDetails.author = @"Author N/A";
        
    } else if (self.specificBookDetails.publisher == (id)[NSNull null]) {
        self.specificBookDetails.publisher = @"Publisher N/A";
        
    } else if (self.specificBookDetails.categories == (id)[NSNull null]) {
        self.specificBookDetails.categories = @"N/A";
        
    } else if (self.specificBookDetails.lastCheckedOutBy == (id)[NSNull null]) {
        self.specificBookDetails.lastCheckedOutBy = @"N/A";

    }
    
    self.bookTitleLabel.text = [NSString stringWithFormat:@"Title: %@", self.specificBookDetails.title];
    self.authorLabel.text = [NSString stringWithFormat:@"Author: %@", self.specificBookDetails.author];
    self.publisherLabel.text = [NSString stringWithFormat:@"Publisher: %@", self.specificBookDetails.publisher];
    self.tagsLabel.text = [NSString stringWithFormat:@"Tags: %@", self.specificBookDetails.categories];
    self.lastCheckedOutByLabel.adjustsFontSizeToFitWidth = YES;
    self.lastCheckedOutByLabel.text = [NSString stringWithFormat:@"%@ at %@", self.specificBookDetails.lastCheckedOutBy, self.specificBookDetails.lastCheckedOutDate];
    
}

- (IBAction)shareButtonPressed:(id)sender
{
    
    NSString *shareText = [NSString stringWithFormat:@"Hey! Check out this book:\n\n%@\n%@\n%@\n%@\n%@", self.bookTitleLabel.text, self.authorLabel.text, self.publisherLabel.text, self.tagsLabel.text, [NSString stringWithFormat:@"Last checked out by: %@", self.lastCheckedOutByLabel.text]];
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:@[shareText] applicationActivities:nil];
    
    [self presentViewController:activityVC animated:YES completion:^{
    }];
}

#pragma mark - Navigation

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if (sender == self.checkoutButton) {
        AALCheckoutViewController *checkoutVC = segue.destinationViewController;
        checkoutVC.specificBookDetails = self.specificBookDetails;
    } else if (sender == self.editButton) {
        AALEditBookViewController *editBookVC = segue.destinationViewController;
        editBookVC.specificBookDetails = self.specificBookDetails;
    }
}

@end
