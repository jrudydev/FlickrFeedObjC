//
//  Photo+Services.h
//  FlickrFeed
//
//  Created by Rudy Gomez on 12/17/17.
//  Copyright © 2017 JRudy Gaming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Photo.h"

typedef void(^PhotoResult)(NSArray<Photo*>*, NSError*);

@interface Photo(Services)

+ (void)getPhotosWithCompletionBlock:(PhotoResult)completion;

@end
