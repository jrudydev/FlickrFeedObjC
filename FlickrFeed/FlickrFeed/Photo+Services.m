//
//  Photo+Services.m
//  FlickrFeed
//
//  Created by Rudy Gomez on 12/17/17.
//  Copyright © 2017 JRudy Gaming. All rights reserved.
//

#import "Photo+Services.h"
#import "NetworkClient.h"

enum {
    NotImplementedError,
    URLPaseError,
    JSONStructureError
} PhotoServiceError;

@implementation Photo(Services)

static NSString* const errorDomain = @"com.JRudyGomez.FlickrFeed.ErrorDomain";
static NSString* const notImplementedError = @"This Feature has not been implemeneted";
static NSString* const urlParseError = @"Sorry, there was an erorr getting the photo";
static NSString* const jsonStructureError = @"Sorry, the photo service returned something different that expected";

+ (void)getPhotosWithCompletionBlock:(PhotoResult)completion {
    NSString *urlString = @"https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1";
    NSURL* url = [NSURL URLWithString:urlString];
    
    [[NetworkClient shared] getURL:url completionBlock:
     ^(id result, NSError* error) {
         if (error != nil) {
             completion(nil, error);
             return;
         }
         
         NSDictionary* resultDict = (NSDictionary*)result;
         if (resultDict != nil) {
             NSDictionary* items = resultDict[@"items"];
             if (items != nil) {
                 NSMutableArray<Photo*>* photos = [[NSMutableArray alloc] init];
                 for (NSDictionary *item in items) {
                     Photo* photo = [[Photo alloc] initWithDict:item];
                     [photos addObject:photo];
                 }
                 completion(photos, nil);
                 return;
             }
         }
         
         completion(nil, [Photo getError:JSONStructureError]);
    }];
}

// MARK: - Helper Methods

+ (NSError*)getError:(int)errorCode {
    NSDictionary* userInfo;
    switch(errorCode) {
        case NotImplementedError: userInfo = @{
                NSLocalizedDescriptionKey:
                    NSLocalizedString(notImplementedError, nil)
            };
            break;
        case URLPaseError: userInfo = @{
                NSLocalizedDescriptionKey:
                    NSLocalizedString(urlParseError, nil)
            };
            break;
        case JSONStructureError: userInfo = @{
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
@end
