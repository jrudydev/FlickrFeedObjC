//
//  PhotoCell.h
//  FlickrFeed
//
//  Created by Rudy Gomez on 12/17/17.
//  Copyright © 2017 JRudy Gaming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Photo.h"

@interface PhotoCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *photoImgeView;
@property (nonatomic) Photo* photo;

- (void)setPhoto:(Photo *)photo;

@end
