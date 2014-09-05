//
//  AALMainBooksTableViewController.m
//  ProlificLibrary
//
//  Created by Albert Lardizabal on 9/2/14.
//  Copyright (c) 2014 Albert Lardizabal. All rights reserved.
//

#import "AALMainBooksTableViewController.h"
#import "AALBookDetailViewController.h"
#import "AALLibraryDataStore.h"
#import "AALAPIClient.h"
#import "AALBook.h"

@interface AALMainBooksTableViewController ()

@property (nonatomic) AALLibraryDataStore *store;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *addBookButton;
@property (nonatomic) UIRefreshControl *refreshControl;

@end

@implementation AALMainBooksTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    self.tableView.allowsMultipleSelectionDuringEditing = NO;
    
    self.store = [AALLibraryDataStore sharedDataStore];
    [self.store getAllBooksWithCompletion:^(BOOL success) {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self.tableView reloadData];
        }];
    }];
    
    // Pull down to refresh table view
    self.refreshControl = [[UIRefreshControl alloc]init];
    [self.tableView addSubview:self.refreshControl];
    [self.refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
}

- (void) viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.store.libraryOfBooks count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"bookCell" forIndexPath:indexPath];
    
    AALBook *tempBook = self.store.libraryOfBooks[indexPath.row];
    
    cell.textLabel.adjustsFontSizeToFitWidth = YES;
    cell.textLabel.font = [UIFont boldSystemFontOfSize:12];
    cell.textLabel.text = tempBook.title;
    
    cell.detailTextLabel.adjustsFontSizeToFitWidth = YES;
    cell.detailTextLabel.font = [UIFont italicSystemFontOfSize:10];
    cell.detailTextLabel.text = tempBook.author;
    
    return cell;
}

#pragma mark - Navigation

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if (sender != self.addBookButton) {
        AALBookDetailViewController *destVC = segue.destinationViewController;
        NSIndexPath *path = [self.tableView indexPathForSelectedRow];
        destVC.specificBookDetails = self.store.libraryOfBooks[path.row];
    }
    
}

#pragma mark - Pull down to refresh table

- (void) refreshTable
{
    [self.store getAllBooksWithCompletion:^(BOOL success) {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self.refreshControl endRefreshing];
            [self.tableView reloadData];
        }];
    }];
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    AALBook *tempBook = self.store.libraryOfBooks[indexPath.row];
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [self.store deleteSingleBookWithID:tempBook.bookID completion:^(BOOL success) {
            [self.store getAllBooksWithCompletion:^(BOOL success) {
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    [self.tableView reloadData];
                    //[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
                }];
            }];
        }];
        
    }
}

- (IBAction)clearAllButtonPressed:(id)sender
{
    UIAlertView *clearAllAlertview = [[UIAlertView alloc] initWithTitle:@"Warning!"
                                                                message:@"Click OK to delete all books."
                                                               delegate:self
                                                      cancelButtonTitle:@"Cancel"
                                                      otherButtonTitles:@"OK", nil];
    clearAllAlertview.delegate = self;
    [clearAllAlertview show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 1)
    {
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }
    
}

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

@end
