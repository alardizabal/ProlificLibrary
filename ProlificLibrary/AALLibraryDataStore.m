//
//  AALLibraryDataStore.m
//  ProlificLibrary
//
//  Created by Albert Lardizabal on 9/2/14.
//  Copyright (c) 2014 Albert Lardizabal. All rights reserved.
//

#import "AALLibraryDataStore.h"
#import "AALBook.h"
#import "AALAPIClient.h"

@implementation AALLibraryDataStore

- (instancetype)init
{
    self = [super init];
    if (self) {
        _libraryOfBooks = [[NSMutableArray alloc]init];
    }
    return self;
}

+ (instancetype)sharedDataStore
{
    static AALLibraryDataStore *_sharedDataStore = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedDataStore = [[AALLibraryDataStore alloc] init];
    });
    
    return _sharedDataStore;
}

- (void) getAllBooksWithCompletion:(void (^)(BOOL success))completionBlock
{
    [AALAPIClient getAllBooksWithCompletion:^(NSArray *allBooks) {
        
        self.libraryOfBooks = [[NSMutableArray alloc]init];
        
        for (NSDictionary *book in allBooks) {
            
            AALBook *tempBook = [[AALBook alloc]init];
            
            
            if (book[@"author"] == [NSNull null]) {
                tempBook.author = @"Author N/A";
            } else {
                tempBook.author = book[@"author"];
            }
            
            NSString *categoryString = book[@"categories"];
            if (categoryString != (id)[NSNull null]) {
                tempBook.categories = [categoryString componentsSeparatedByString:@","];
            }
            
            tempBook.bookID = book[@"id"];
            tempBook.lastCheckedOutDate = book[@"lastCheckedOut"];
            tempBook.lastCheckedOutBy = book[@"lastCheckedOutBy"];
            tempBook.publisher = book[@"publisher"];
            
            if (book[@"title"] == [NSNull null]) {
                tempBook.title = @"Title N/A";
            } else {
                tempBook.title = book[@"title"];
            }
            
            tempBook.url = book[@"url"];
            
            [self.libraryOfBooks addObject:tempBook];
        }

        NSSortDescriptor *sortByTitle = [[NSSortDescriptor alloc] initWithKey:@"title" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)];
        [self.libraryOfBooks sortUsingDescriptors:@[sortByTitle]];
        
        completionBlock(YES);
        
    }];
    
}

- (void) addLibraryBookWithTitle:(NSString *)title
                          author:(NSString *)author
                      categories:(NSString *)categories
                       publisher:(NSString *)publisher
                      completion:(void (^)(BOOL))completionBlock
{
    [AALAPIClient addLibraryBookWithTitle:title
                                   author:author
                               categories:categories
                                publisher:publisher
                               completion:^(BOOL success) {
                                   
                                   completionBlock(YES);
                                   
                               }];
}

- (void) deleteSingleBookWithID:(id)bookID
                     completion:(void (^)(BOOL))completionBlock
{
    [AALAPIClient deleteSingleBookWithID:bookID completion:^(BOOL success) {
        completionBlock(YES);
    }];
}

@end
