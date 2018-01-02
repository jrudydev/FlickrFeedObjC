//
//  FlickrFeedNetworkClientTests.m
//  FlickrFeedTests
//
//  Created by Rudy Gomez on 12/28/17.
//  Copyright © 2017 JRudy Gaming. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "FlickrFeedTestsConstants.h"
#import "NetworkClient.h"
#import "Photo.h"
#import "Utilities.h"


@interface FlickrFeedNetworkClientTests : XCTestCase

@end

static NSDictionary* item1NetworkResult = nil;
static NSDictionary* item2NetworkResult = nil;

// MARK: Mock Objects

@interface MockNetworkClient : NetworkClient
- (void)getURL:(NSURL*)url completionBlock:(NetworkResult)completion;
//- (void)parseJSON:(NSData*)data completionBlock:(NetworkResult)completion;
@end

@implementation MockNetworkClient
- (void)getURL:(NSURL*)url completionBlock:(NetworkResult)completion {
    completion(item1NetworkResult, nil);
}
//- (void)parseJSON:(NSData*)data completionBlock:(NetworkResult)completion {
//    completion(item1NetworkResult, nil);
//}
@end

@implementation FlickrFeedNetworkClientTests {
    MockNetworkClient *_networkClient;
}

// MARK: Setup Methods

- (void)setUp {
    [super setUp];
    _networkClient = [MockNetworkClient shared];
    item1NetworkResult = @{
                           FlickrFeedPhotoLinkKey: FlickrFeedPhotoTestItemId1,
                           FlickrFeedPhotoMediaKey: @{
                                   FlickrFeedPhotoMKey: FlickrFeedPhotoTestUrl
                                   }
                           };
    item2NetworkResult = @{
                           FlickrFeedPhotoLinkKey: FlickrFeedPhotoTestItemId2,
                           FlickrFeedPhotoMediaKey: @{
                                   FlickrFeedPhotoMKey: FlickrFeedPhotoTestUrl
                                   }
                           
                           };
}

- (void)tearDown {
    _networkClient = nil;
    item1NetworkResult = nil;
    item2NetworkResult = nil;
    [super tearDown];
}

// MARK: JSON Parsing

- (void)testNetworkClientGetUrl {
    
}

- (void)testNetworkClientParseJSONDictionary {
    NSData *jsonData = [NSKeyedArchiver
                        archivedDataWithRootObject:item1NetworkResult];
    
    [_networkClient parseJSON:jsonData completionBlock:
     ^(id result, NSError* error) {
         if (error != nil) {
             NSError *error = [Utilities getError:URLPaseError];
             NSLog(@"%@", error.localizedDescription);
             XCTAssert(false, @"Error parsing data");
             return;
         }
         
         NSDictionary *dictionary = (NSDictionary *)result;
         if (dictionary == nil) {
             NSError *error = [Utilities getError:JSONStructureError];
             NSLog(@"%@", error.localizedDescription);
             XCTAssert(false, "Error parsing data");
             return;
         }
         XCTAssert(dictionary == item1NetworkResult, "Values do not match");
    }];
}

- (void)testNetworkClientParseJSONArray {
    
}

@end
