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
    
    NSLog(@"%@", getAllBooksURL);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:getAllBooksURL
      parameters:nil
         success:^(NSURLSessionDataTask *task, id responseObject)
     {
         [backgroundQueue addOperationWithBlock:^{
             NSLog(@"%@", responseObject);
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

- (void) addLibraryBook
{
    
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
