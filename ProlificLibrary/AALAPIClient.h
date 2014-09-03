//
//  AALAPIClient.h
//  ProlificLibrary
//
//  Created by Albert Lardizabal on 9/2/14.
//  Copyright (c) 2014 Albert Lardizabal. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AALBook;

@interface AALAPIClient : NSObject

+ (void) getAllBooksWithCompletion:(void (^)(NSArray *allBooks))completionBlock;
- (AALBook *) getSingleBook;

+ (void) addLibraryBookWithTitle:(NSString *)title
                          author:(NSString *)author
                      categories:(NSString *)categories
                       publisher:(NSString *)publisher
                      completion:(void (^)(BOOL success))completionBlock;

- (void) updateLibraryBook;

- (void) deleteSingleBook;
- (void) deleteAllBooks;

@end
