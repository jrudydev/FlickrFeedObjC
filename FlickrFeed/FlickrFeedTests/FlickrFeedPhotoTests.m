//
//  FlickrFeedPhotoTests.m
//  FlickrFeedTests
//
//  Created by Rudy Gomez on 12/26/17.
//  Copyright © 2017 JRudy Gaming. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "FlickrFeedTestsConstants.h"
#import "Photo.h"

@interface FlickrFeedPhotoTests : XCTestCase

@end

@implementation FlickrFeedPhotoTests{
    NSDictionary *_item1NetworkResult;
    NSDictionary *_item2NetworkResult;
}

- (void)setUp {
    [super setUp];
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
    _item1NetworkResult = nil;
    _item2NetworkResult = nil;
    [super tearDown];
}

- (void)testPhotoCreation {
    Photo *photo = [[Photo alloc] initWithDict:_item1NetworkResult];
    XCTAssertNotNil(photo);
    XCTAssertEqual(photo.itemId, FlickrFeedPhotoTestItemId1);
    XCTAssertEqual((NSString*)photo.photoUrl, FlickrFeedPhotoTestUrl);
    XCTAssertEqual(photo.favorite, false);
}

- (void)testPhotoEquality {
    Photo *photo1 = [[Photo alloc] initWithDict:_item1NetworkResult];
    Photo *photo2 = [[Photo alloc] initWithDict:_item2NetworkResult];
    Photo *photo3 = [[Photo alloc] initWithDict:_item2NetworkResult];
    XCTAssert(![photo1 isEqual:photo2], @"The photos are equal");
    XCTAssert([photo2 isEqual:photo3], @"The photos are not equal");
}

@end
