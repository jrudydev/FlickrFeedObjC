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

static NSDictionary *item1NetworkResult = nil;
static NSDictionary *item2NetworkResult = nil;
static NSString *resultJSONDictionaryFileName = nil;
static NSString *resultJSONArrayFileName = nil;

// MARK: Mock Objects

@interface MockNetworkClient : NetworkClient
- (void)getURL:(NSURL*)url completionBlock:(NetworkResult)completion;
@end

@implementation MockNetworkClient
- (void)getURL:(NSURL*)url completionBlock:(NetworkResult)completion {
    completion(item1NetworkResult, nil);
}
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
    
    resultJSONDictionaryFileName = @"MockServerResponseDictionary";
    resultJSONArrayFileName = @"MockServerResponseArra";
}

- (void)tearDown {
    _networkClient = nil;
    item1NetworkResult = nil;
    item2NetworkResult = nil;
    resultJSONDictionaryFileName = nil;
    resultJSONArrayFileName = nil;
    [super tearDown];
}

// MARK: JSON Parsing

- (void)testNetworkClientGetUrl {
    
}

- (void)testNetworkClientParseJSONDictionary {
    NSString *filePath = [[NSBundle mainBundle]
                          pathForResource:resultJSONDictionaryFileName
                          ofType:@"json"];
    NSData *jsonData = [[NSData alloc] initWithContentsOfFile:filePath];
    
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
         NSString *resultLink = dictionary[FlickrFeedPhotoLinkKey];
         NSString *expectedLink = item1NetworkResult[FlickrFeedPhotoLinkKey];
         XCTAssert([resultLink isEqualToString:expectedLink],
                   "Links do not match");
         NSDictionary *resultMedia = dictionary[FlickrFeedPhotoMediaKey];
         NSDictionary *expectedMedia = item1NetworkResult[FlickrFeedPhotoMediaKey];
         NSString *resultMString = resultMedia[FlickrFeedPhotoMKey];
         NSString *expectedMString = expectedMedia[FlickrFeedPhotoMKey];
         XCTAssert([resultMString isEqualToString:expectedMString],
                   "M strings do not match");
    }];
}

- (void)testNetworkClientParseJSONArray {
    
}

@end
