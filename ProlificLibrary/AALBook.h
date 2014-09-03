//
//  AALBook.h
//  ProlificLibrary
//
//  Created by Albert Lardizabal on 9/2/14.
//  Copyright (c) 2014 Albert Lardizabal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AALBook : NSObject

@property (nonatomic) NSString *author;
@property (nonatomic) NSArray *categories;
@property (nonatomic) id bookID;
@property (nonatomic) NSDate *lastCheckedOutDate;
@property (nonatomic) NSString *lastCheckedOutBy;
@property (nonatomic) NSString *publisher;
@property (nonatomic) NSString *title;
@property (nonatomic) NSString *url;

@end
