//
//  AALEditBookViewController.h
//  ProlificLibrary
//
//  Created by Albert Lardizabal on 9/4/14.
//  Copyright (c) 2014 Albert Lardizabal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AALBook.h"

@interface AALEditBookViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic) AALBook *specificBookDetails;

@end
