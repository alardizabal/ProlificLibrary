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

@end
