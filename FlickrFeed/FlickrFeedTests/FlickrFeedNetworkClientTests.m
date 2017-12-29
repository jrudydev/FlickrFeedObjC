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


@interface FlickrFeedNetworkClientTests : XCTestCase

@end

// MARK: Mock Objects

@interface MockNetworkClient : NetworkClient
- (void)getURL:(NSURL*)url completionBlock:(NetworkResult)completion;
- (void)parseJSON:(NSData*)data completionBlock:(NetworkResult)completion;
@end

@implementation MockNetworkClient

- (void)getURL:(NSURL*)url completionBlock:(NetworkResult)completion {
//    completion(FlickrFeedNetworkClientTests.item1NetworkResult, nil);
}

- (void)parseJSON:(NSData*)data completionBlock:(NetworkResult)completion {
    completion(data, nil);
}

@end

@implementation FlickrFeedNetworkClientTests {
    NetworkClient *_networkClient;
    NSDictionary *_item1NetworkResult;
    NSDictionary *_item2NetworkResult;
}

- (void)setUp {
    [super setUp];
    _networkClient = [NetworkClient shared];
    _item1NetworkResult = @{
                           FlickrFeedPhotoLinkKey: FlickrFeedPhotoTestItemId1,
                           FlickrFeedPhotoMediaKey: @{
                                   FlickrFeedPhotoMKey: FlickrFeedPhotoTestUrl
                                   }
                           };
    _item2NetworkResult = @{
                           FlickrFeedPhotoLinkKey: FlickrFeedPhotoTestItemId2,
                           FlickrFeedPhotoMediaKey: @{
                                   FlickrFeedPhotoMKey: FlickrFeedPhotoTestUrl
                                   }
                           
                           };
}

- (void)tearDown {
    _networkClient = nil;
    _item1NetworkResult = nil;
    _item2NetworkResult = nil;
    [super tearDown];
}

// MARK: JSON Parsing

- (void)testNetworkClientParseJSONDictionary {
    
}

- (void)testNetworkClientParseJSONArray {
    
}

@end
