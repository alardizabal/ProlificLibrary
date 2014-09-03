//
//  AALAPIClient.m
//  ProlificLibrary
//
//  Created by Albert Lardizabal on 9/2/14.
//  Copyright (c) 2014 Albert Lardizabal. All rights reserved.
//

#import "AFNetworking.h"
#import "AALAPIClient.h"
#import "AALLibraryDataStore.h"
#import "AALConstants.h"
#import "AALBook.h"

@implementation AALAPIClient

+ (void) getAllBooksWithCompletion:(void (^)(NSArray *allBooks))completionBlock
{

    NSOperationQueue *backgroundQueue = [[NSOperationQueue alloc] init];
    NSString *getAllBooksURL = [NSString stringWithFormat:@"%@books", kPROLIFIC_API_PATH];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:getAllBooksURL
      parameters:nil
         success:^(NSURLSessionDataTask *task, id responseObject)
     {
         [backgroundQueue addOperationWithBlock:^{
             completionBlock(responseObject);
         }];
         
         
     } failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         NSLog(@"Fail: %@",error.localizedDescription);
     }];
    
}

- (AALBook *) getSingleBook
{
    return nil;
}

+ (void) addLibraryBookWithTitle:(NSString *)title
                          author:(NSString *)author
                      categories:(NSString *)categories
                       publisher:(NSString *)publisher
                      completion:(void (^)(BOOL))completionBlock
{
    
    NSOperationQueue *backgroundQueue = [[NSOperationQueue alloc] init];
    NSString *addBookURL = [NSString stringWithFormat:@"%@books/", kPROLIFIC_API_PATH];
   
    NSDictionary *params = @{@"title":title, @"author":author, @"categories":categories, @"publisher":publisher};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    [manager POST:addBookURL
      parameters:params
         success:^(NSURLSessionDataTask *task, id responseObject)
     {
         [backgroundQueue addOperationWithBlock:^{
             NSLog(@"Post %@", responseObject);
             completionBlock(responseObject);
         }];
         
         
     } failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         NSLog(@"Fail: %@",error.localizedDescription);
     }];
    
}

- (void) updateLibraryBook
{
    
}

- (void) deleteSingleBook
{
    
}

- (void) deleteAllBooks
{
    
}

@end
