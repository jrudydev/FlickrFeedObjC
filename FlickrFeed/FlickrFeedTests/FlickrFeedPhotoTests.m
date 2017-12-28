//
//  FlickrFeedPhotoTests.m
//  FlickrFeedTests
//
//  Created by Rudy Gomez on 12/26/17.
//  Copyright © 2017 JRudy Gaming. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Photo.h"

@interface FlickrFeedPhotoTests : XCTestCase

@end

@implementation FlickrFeedPhotoTests{
    NSDictionary *_values1;
    NSDictionary *_values2;
}

static NSString* const FlickrFeedPhotoItemId1 = @"FlickrFeedPhotoItemId1";
static NSString* const FlickrFeedPhotoItemId2 = @"FlickrFeedPhotoItemId2";
static NSString* const FlickrFeedPhotoPhotoUrl = @"http://www.example.com?a=b&b=c";

- (void)setUp {
    [super setUp];
    _values1 = @{
                 FlickrFeedPhotoLinkKey: FlickrFeedPhotoItemId1,
                 FlickrFeedPhotoMediaKey: @{
                         FlickrFeedPhotoMKey: FlickrFeedPhotoPhotoUrl
                         }
                 };
    _values2 = @{
                 FlickrFeedPhotoLinkKey: FlickrFeedPhotoItemId2,
                 FlickrFeedPhotoMediaKey: @{
                         FlickrFeedPhotoMKey: FlickrFeedPhotoPhotoUrl
                         }
                 };
}

- (void)tearDown {
    _values1 = nil;
    _values2 = nil;
    [super tearDown];
}

- (void)testPhotoCreation {
    Photo *photo = [[Photo alloc] initWithDict:_values1];
    XCTAssertNotNil(photo);
    XCTAssertEqual(photo.itemId, FlickrFeedPhotoItemId1);
    XCTAssertEqual((NSString*)photo.photoUrl, FlickrFeedPhotoPhotoUrl);
    XCTAssertEqual(photo.favorite, false);
}

- (void)testPhotoEquality {
    Photo *photo1 = [[Photo alloc] initWithDict:_values1];
    Photo *photo2 = [[Photo alloc] initWithDict:_values2];
    Photo *photo3 = [[Photo alloc] initWithDict:_values2];
    XCTAssert(![photo1 isEqual:photo2], @"The photos are equal");
    XCTAssert([photo2 isEqual:photo3], @"The photos are not equal");
}

@end
