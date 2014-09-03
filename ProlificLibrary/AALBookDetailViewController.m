//
//  AALBookDetailViewController.m
//  ProlificLibrary
//
//  Created by Albert Lardizabal on 9/2/14.
//  Copyright (c) 2014 Albert Lardizabal. All rights reserved.
//

#import "AALBookDetailViewController.h"

@interface AALBookDetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *bookTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *publisherLabel;
@property (weak, nonatomic) IBOutlet UILabel *tagsLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastCheckedOutByLabel;

@end

@implementation AALBookDetailViewController

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
    
    if (self.specificBookDetails.title == (id)[NSNull null]) {
        self.specificBookDetails.title = @"Title N/A";
        
    } else if (self.specificBookDetails.author == (id)[NSNull null]) {
        self.specificBookDetails.author = @"Author N/A";
        
    } else if (self.specificBookDetails.publisher == (id)[NSNull null]) {
        self.specificBookDetails.publisher = @"Publisher N/A";
        
    } else if (self.specificBookDetails.categories == (id)[NSNull null]) {
        self.specificBookDetails.categories = @[@"N/A"];
        
    } else if (self.specificBookDetails.lastCheckedOutBy == (id)[NSNull null]) {
        self.specificBookDetails.lastCheckedOutBy = @"N/A";
        
    }
    
    self.bookTitleLabel.text = self.specificBookDetails.title;
    self.authorLabel.text = self.specificBookDetails.author;
    self.publisherLabel.text = self.specificBookDetails.publisher;
    self.tagsLabel.text = [self.specificBookDetails.categories componentsJoinedByString:@","];
    self.lastCheckedOutByLabel.text = self.specificBookDetails.lastCheckedOutBy;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
