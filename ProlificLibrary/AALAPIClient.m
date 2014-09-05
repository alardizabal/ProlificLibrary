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
             completionBlock(responseObject);
         }];
         
         
     } failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         NSLog(@"Fail: %@",error.localizedDescription);
     }];
    
}

+ (void) updateLibraryBookWithTitle:(NSString *)title
                             author:(NSString *)author
                             bookID:(id)bookID
                         categories:(NSString *)categories
                          publisher:(NSString *)publisher
                   lastCheckedOutBy:(NSString *)fullName
                         completion:(void (^)(BOOL))completionBlock
{
    
    NSOperationQueue *backgroundQueue = [[NSOperationQueue alloc] init];
    NSString *updateBookDetailURL = [NSString stringWithFormat:@"%@books/%@", kPROLIFIC_API_PATH, bookID];
    
    NSDictionary *params = @{@"title":title, @"author":author, @"categories":categories, @"publisher":publisher, @"lastCheckedOutBy":fullName};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager PUT:updateBookDetailURL
      parameters:params
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

+ (void) checkoutLibraryBookWithName:(NSString *)fullName
                              bookID:(id)bookID
                        checkoutDate:(NSDate *)checkoutDate
                          completion:(void (^)(BOOL))completionBlock
{
    
    NSOperationQueue *backgroundQueue = [[NSOperationQueue alloc] init];
    NSString *checkoutBookURL = [NSString stringWithFormat:@"%@books/%@", kPROLIFIC_API_PATH, bookID];
    
    NSDictionary *params = @{@"lastCheckedOutBy":fullName, @"lastCheckedOut":checkoutDate};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager PUT:checkoutBookURL
      parameters:params
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

+ (void) deleteSingleBookWithID:(id)bookID
                     completion:(void (^)(BOOL))completionBlock
{
    
    NSOperationQueue *backgroundQueue = [[NSOperationQueue alloc] init];
    NSString *deleteBookURL = [NSString stringWithFormat:@"%@books/%@", kPROLIFIC_API_PATH, bookID];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager DELETE:deleteBookURL
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

+ (void) deleteAllBooksWithCompletion:(void (^)(BOOL))completionBlock
{
    
    NSOperationQueue *backgroundQueue = [[NSOperationQueue alloc] init];
    NSString *deleteAllBooksURL = [NSString stringWithFormat:@"%@clean", kPROLIFIC_API_PATH];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager DELETE:deleteAllBooksURL
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

@end
