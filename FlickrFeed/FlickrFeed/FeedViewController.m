//
//  FeedViewController.m
//  FlickrFeed
//
//  Created by Rudy Gomez on 12/17/17.
//  Copyright © 2017 JRudy Gaming. All rights reserved.
//

#import "FeedViewController.h"
#import "MessageCell.h"
#import "PhotoCell.h"
#import "Photo.h"
#import "Photo+Services.h"

@interface FeedViewController () {
    NSMutableArray<Photo*>* _photos;
    NSString* _currentMessage;
}
@end

@implementation FeedViewController

static NSString * const reusePhotoIdentifier = @"photoCell";
static NSString * const reuseMessageIdentifier = @"messageCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    //[self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    _currentMessage = @"Loading photos...";
    _photos = [[NSMutableArray alloc] init];
    
    [Photo getPhotosWithCompletionBlock:^(NSArray<Photo*>* photos, NSError *error) {
        if (error != nil) {
            if ([error isKindOfClass:[NSError class]]) {
                _currentMessage = [error localizedDescription];
            }
            _photos = nil;
            dispatch_sync(dispatch_get_main_queue(), ^{
                [self.collectionView reloadData];
            });
            
            return;
        }
        _photos = [photos mutableCopy];
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
        });
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// MARK: - Helper Methods

- (BOOL)isPhotoArrayEmpty {
    return (_photos == nil ||
            [_photos count] == 0);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return ([self isPhotoArrayEmpty]) ? 1: [_photos count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell* cell;
    if ([self isPhotoArrayEmpty]) {
        MessageCell *messageCell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseMessageIdentifier forIndexPath:indexPath];
        messageCell.messageLabel.text = _currentMessage;
        cell = messageCell;
    } else {
        PhotoCell *photoCell = [collectionView dequeueReusableCellWithReuseIdentifier:reusePhotoIdentifier forIndexPath:indexPath];
        photoCell.photo = _photos[indexPath.row];
        cell = photoCell;
    }
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
