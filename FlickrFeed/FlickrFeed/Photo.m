//
//  Photo.m
//  FlickrFeed
//
//  Created by Rudy Gomez on 12/17/17.
//  Copyright © 2017 JRudy Gaming. All rights reserved.
//

#import "Photo.h"

@implementation Photo

static NSString* const itemIdKey = @"itemId";
static NSString* const photoUrlKey = @"photoUrl";
static NSString* const favoriteKey = @"favoriteKey";

- (instancetype)initWithDict:(NSDictionary*)dict {
    if (self = [super init]) {
        if (dict != nil) {
            if ([dict objectForKey:FlickrFeedPhotoLinkKey] == nil) {
                NSString* errorStr = @"Photo item could not be create:%@";
                [NSException raise:@"ObjectNotCreated"
                            format: errorStr, dict.description];
            }
            _itemId = (NSString*)dict[FlickrFeedPhotoLinkKey];
            
            if ([dict objectForKey:FlickrFeedPhotoLinkKey] == nil ||
                dict[FlickrFeedPhotoMediaKey][FlickrFeedPhotoMKey] == nil) {
                NSString* errorStr = @"Photo item could not be create:%@";
                [NSException raise:@"ObjectNotCreated"
                            format: errorStr, dict.description];
            }
            _photoUrl= (NSURL*)dict[FlickrFeedPhotoMediaKey][FlickrFeedPhotoMKey];
        }
    }
    return self;
}

// MARK: - Equatable

- (BOOL)isEqual:(id)object {
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[Photo class]]) {
        return NO;
    }
    
    Photo* photo = (Photo*)object;
    return [_itemId isEqualToString:photo.itemId];
}

@end
