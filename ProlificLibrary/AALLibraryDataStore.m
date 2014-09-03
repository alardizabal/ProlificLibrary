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

        for (NSDictionary *book in allBooks) {
            
            AALBook *tempBook = [[AALBook alloc]init];
            tempBook.author = book[@"author"];
            
            NSString *categoryString = book[@"categories"];
            tempBook.categories = [categoryString componentsSeparatedByString:@","];
            
            tempBook.bookID = book[@"id"];
            tempBook.lastCheckedOut = book[@"lastCheckedOut"];
            tempBook.lastCheckedOutBy = book[@"lastCheckedOutBy"];
            tempBook.publisher = book[@"publisher"];
            tempBook.title = book[@"title"];
            tempBook.url = book[@"url"];
            
            [self.libraryOfBooks addObject:tempBook];
        }
        
        completionBlock(YES);
        
    }];
    
}

@end
