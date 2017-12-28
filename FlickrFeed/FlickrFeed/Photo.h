//
//  Photo.h
//  FlickrFeed
//
//  Created by Rudy Gomez on 12/17/17.
//  Copyright © 2017 JRudy Gaming. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString* const FlickrFeedPhotoLinkKey = @"link";
static NSString* const FlickrFeedPhotoMediaKey = @"media";
static NSString* const FlickrFeedPhotoMKey = @"m";

@interface Photo : NSObject

@property(nonatomic) NSString* itemId;
@property(nonatomic) NSURL* photoUrl;
@property(assign) BOOL favorite;

- (instancetype)initWithDict:(NSDictionary*)dict;
- (BOOL)isEqual:(id)object;

@end
