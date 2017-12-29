//
//  NetworkClient.h
//  FlickrFeed
//
//  Created by Rudy Gomez on 12/17/17.
//  Copyright © 2017 JRudy Gaming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^NetworkResult)(id, NSError*);
typedef void(^ImageResult)(UIImage*, NSError*);

@interface NetworkClient : NSObject

+ (instancetype)shared;
- (id)init __attribute__ ((unavailable("Init unavailable for this class, use +[NetworkClient]shared instead.]")));
- (void)getURL:(NSURL*)url completionBlock:(NetworkResult)completion;
- (void)parseJSON:(NSData*)data completionBlock:(NetworkResult)completion;

@end
