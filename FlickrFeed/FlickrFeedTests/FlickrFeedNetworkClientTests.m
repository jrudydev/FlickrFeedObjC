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
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}



@end
