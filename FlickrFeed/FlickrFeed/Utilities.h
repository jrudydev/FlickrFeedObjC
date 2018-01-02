//
//  Utilities.h
//  FlickrFeed
//
//  Created by Rudy Gomez on 12/31/17.
//  Copyright © 2017 JRudy Gaming. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    NotImplementedError,
    URLPaseError,
    JSONStructureError
} PhotoServiceError;

@interface Utilities : NSObject

+ (NSError*)getError:(int)errorCode;
+ (void)threadSafeExecutionBlock:(void (^) (void))block;

@end
