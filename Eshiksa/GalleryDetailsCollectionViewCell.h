//
//  GalleryDetailsCollectionViewCell.h
//  Eshiksa
//
//  Created by Punit on 05/05/18.
//  Copyright © 2018 Akhilesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GalleryDetailsCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *images;
@property (weak, nonatomic) IBOutlet UIImageView *video;

@property (weak, nonatomic) IBOutlet UILabel *folderid;
@end
