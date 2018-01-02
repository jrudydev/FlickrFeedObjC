//
//  NetworkClient.m
//  FlickrFeed
//
//  Created by Rudy Gomez on 12/17/17.
//  Copyright © 2017 JRudy Gaming. All rights reserved.
//

#import "NetworkClient.h"
#import "Utilities.h"

@implementation NetworkClient {
    NSURLSession* _urlSession;
}

+ (instancetype)shared {
    static id instance;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (id)init {
    if(self = [super init]) {
        NSURLSessionConfiguration* configuration =
        [NSURLSessionConfiguration defaultSessionConfiguration];
        _urlSession = [NSURLSession sessionWithConfiguration:configuration];
    }
    return self;
}

- (void)getURL:(NSURL*)url completionBlock:(NetworkResult)completion {
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    NSURLSessionDataTask* task = [_urlSession dataTaskWithRequest:request
        completionHandler:^(NSData *data,
                            NSURLResponse *response,
                            NSError* error){
            if (data == nil) {
                completion(nil, error);
                return;
            }
            [self parseJSON:data completionBlock:completion];
    }];
    [task resume];
}

// MARK: - Helper Methods

- (void)parseJSON:(NSData*)data completionBlock:(NetworkResult)completion {
    NSError* error;
    NSDictionary* parseResults = [NSJSONSerialization
                                  JSONObjectWithData:data options:kNilOptions
                                  error:&error];
    
    if (parseResults != nil) {
        [Utilities threadSafeExecutionBlock:^ {
            completion(parseResults, nil);
        }];
    } else {
        [Utilities threadSafeExecutionBlock:^ {
            completion(nil, error);
        }];
    }
}

@end
