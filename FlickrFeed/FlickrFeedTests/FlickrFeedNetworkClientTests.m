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
    NSArray *result = @[item1NetworkResult, item2NetworkResult];
    completion(result, nil);
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
    resultJSONArrayFileName = @"MockServerResponseArray";
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
    NSString *desc = [NSString stringWithFormat:@"%s%d", __FUNCTION__, __LINE__];
    XCTestExpectation* expect = [self expectationWithDescription:desc];
    
    NSURL *url = [NSURL URLWithString:@"https://www.flickr.com/services/"];
    [[NetworkClient shared] getURL:url completionBlock:
     ^(id result, NSError* error) {
         NSDictionary *dictionary = (NSDictionary *)result;
         NSString *resultLink = dictionary[FlickrFeedPhotoLinkKey];
         XCTAssert([resultLink isEqualToString:FlickrFeedPhotoTestItemId1],
                   "Links do not match");
         NSDictionary *resultMedia = dictionary[FlickrFeedPhotoMediaKey];
         NSString *resultMString = resultMedia[FlickrFeedPhotoMKey];
         XCTAssert([resultMString isEqualToString:FlickrFeedPhotoTestUrl],
                   "M strings do not match");
         
         [expect fulfill];
     }];
    
    [self waitForExpectationsWithTimeout:1.0 handler: ^(NSError *error) {
        if (error != nil) {
            NSLog(@"%@", error.localizedDescription);
            XCTFail( @"waitForExpectationWithTimeout error");
        }
    }];
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
             XCTFail(@"Error parsing data");
             return;
         }
         
         if (result == nil || ![result isKindOfClass:[NSDictionary class]]) {
             NSError *error = [Utilities getError:JSONStructureError];
             NSLog(@"%@", error.localizedDescription);
             XCTFail("Error parsing data");
             return;
         }
         
         NSDictionary *dictionary = (NSDictionary *)result;
         NSString *resultLink = dictionary[FlickrFeedPhotoLinkKey];
         XCTAssert([resultLink isEqualToString:FlickrFeedPhotoTestItemId1],
                   "Links do not match");
         NSDictionary *resultMedia = dictionary[FlickrFeedPhotoMediaKey];
         NSString *resultMString = resultMedia[FlickrFeedPhotoMKey];
         XCTAssert([resultMString isEqualToString:FlickrFeedPhotoTestUrl],
                   "M strings do not match");
    }];
}

- (void)testNetworkClientParseJSONArray {
    NSString *filePath = [[NSBundle mainBundle]
                          pathForResource:resultJSONArrayFileName
                          ofType:@"json"];
    NSData *jsonData = [[NSData alloc] initWithContentsOfFile:filePath];
    
    [_networkClient parseJSON:jsonData completionBlock:
     ^(id result, NSError* error) {
         if (error != nil) {
             NSError *error = [Utilities getError:URLPaseError];
             NSLog(@"%@", error.localizedDescription);
             XCTFail(@"Error parsing data");
             return;
         }
         
         NSDictionary *dictionary = (NSDictionary *)result;
         if (dictionary == nil) {
             NSError *error = [Utilities getError:JSONStructureError];
             NSLog(@"%@", error.localizedDescription);
             XCTFail("Error parsing data");
             return;
         }
         
         NSArray *resultArray = (NSArray *)result;
         XCTAssert(resultArray.count == 2, "Does not have two elements");
         NSDictionary *resultDictinary1 = result[0];
         NSDictionary *resultDictinary2 = result[1];
         
         NSString *resultLink1 = resultDictinary1[FlickrFeedPhotoLinkKey];
         XCTAssert([resultLink1 isEqualToString:FlickrFeedPhotoTestItemId1],
                   "Links do not match");
         NSDictionary *resultMedia1 = resultDictinary1[FlickrFeedPhotoMediaKey];
         NSString *resultMString1 = resultMedia1[FlickrFeedPhotoMKey];
         XCTAssert([resultMString1 isEqualToString:FlickrFeedPhotoTestUrl],
                   "M strings do not match");
         
         NSString *resultLink2 = resultDictinary2[FlickrFeedPhotoLinkKey];
         XCTAssert([resultLink2 isEqualToString:FlickrFeedPhotoTestItemId2],
                   "Links do not match");
         NSDictionary *resultMedia2 = resultDictinary2[FlickrFeedPhotoMediaKey];
         NSString *resultMString2 = resultMedia2[FlickrFeedPhotoMKey];
         XCTAssert([resultMString2 isEqualToString:FlickrFeedPhotoTestUrl],
                   "M strings do not match");
     }];
}

@end
