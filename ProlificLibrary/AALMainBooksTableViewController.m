//
//  AALMainBooksTableViewController.m
//  ProlificLibrary
//
//  Created by Albert Lardizabal on 9/2/14.
//  Copyright (c) 2014 Albert Lardizabal. All rights reserved.
//

#import "AALMainBooksTableViewController.h"
#import "AALLibraryDataStore.h"
#import "AALAPIClient.h"
#import "AALBook.h"

@interface AALMainBooksTableViewController ()

@property (nonatomic) AALLibraryDataStore *store;

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
    
    self.store = [AALLibraryDataStore sharedDataStore];
    [self.store getAllBooksWithCompletion:^(BOOL success) {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self.tableView reloadData];
        }];
    }];
    
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
    cell.textLabel.text = tempBook.title;
    
    return cell;
}

#pragma mark - Navigation

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    //    FISCitizensTableViewController *destVC = segue.destinationViewController;
    //    NSIndexPath *path = [self.tableView indexPathForSelectedRow];
    //
    //    City *cityToPass = self.resultController.fetchedObjects[path.row];
    //
    //    NSSortDescriptor *citizenSorter = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)];
    //    NSArray *tempArray = [[NSArray arrayWithArray:[cityToPass.citizens allObjects]]sortedArrayUsingDescriptors:@[citizenSorter]];
    //
    //    destVC.citizens = tempArray;
    
}


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

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
