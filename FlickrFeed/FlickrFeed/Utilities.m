//
//  Utilities.m
//  FlickrFeed
//
//  Created by Rudy Gomez on 12/31/17.
//  Copyright © 2017 JRudy Gaming. All rights reserved.
//

#import "Utilities.h"

@implementation Utilities

static NSString* const errorDomain = @"com.JRudyGomez.FlickrFeed.ErrorDomain";
static NSString* const notImplementedError = @"Feature has not been implemeneted";
static NSString* const urlParseError = @"There was an erorr parsing the response";
static NSString* const jsonStructureError = @"Invalid JSON structure returned";

+ (NSError*)getError:(int)errorCode {
    NSDictionary* userInfo;
    switch(errorCode) {
        case NotImplementedError:
            userInfo = @{
                         NSLocalizedDescriptionKey:
                             NSLocalizedString(notImplementedError, nil)
                         };
            break;
        case URLPaseError:
            userInfo = @{
                         NSLocalizedDescriptionKey:
                             NSLocalizedString(urlParseError, nil)
                         };
            break;
        case JSONStructureError:
            userInfo = @{
                         NSLocalizedDescriptionKey:
                             NSLocalizedString(jsonStructureError, nil)
                         };
            break;
    }
    
    NSError* error = [NSError errorWithDomain:errorDomain
                                         code:errorCode
                                     userInfo:userInfo];
    return error;
}

// Prevents a threading exception while running async unit tests
+ (void)threadSafeExecutionBlock:(void (^) (void))block {
    if ([NSThread isMainThread]) {
        block();
    } else {
        dispatch_sync(dispatch_get_main_queue(), ^{
            block();
        });
    }
}

@end
