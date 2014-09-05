//
//  AALLibraryDataStore.h
//  ProlificLibrary
//
//  Created by Albert Lardizabal on 9/2/14.
//  Copyright (c) 2014 Albert Lardizabal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AALLibraryDataStore : NSObject

@property (nonatomic) NSMutableArray *libraryOfBooks;

+ (instancetype)sharedDataStore;

- (void) getAllBooksWithCompletion:(void (^)(BOOL success))completionBlock;

- (void) addLibraryBookWithTitle:(NSString *)title
                          author:(NSString *)author
                      categories:(NSString *)categories
                       publisher:(NSString *)publisher
                      completion:(void (^)(BOOL success))completionBlock;

- (void) updateLibraryBookWithTitle:(NSString *)title
                             author:(NSString *)author
                             bookID:(id)bookID
                         categories:(NSString *)categories
                          publisher:(NSString *)publisher
                   lastCheckedOutBy:(NSString *)lastCheckedOutBy
                         completion:(void (^)(BOOL success))completionBlock;

- (void) checkoutLibraryBookWithName:(NSString *)fullName
                              bookID:(id)bookID
                        checkoutDate:(NSDate *)checkoutDate
                          completion:(void (^)(BOOL success))completionBlock;

- (void) deleteSingleBookWithID:(id)bookID
                     completion:(void (^)(BOOL success))completionBlock;

@end
