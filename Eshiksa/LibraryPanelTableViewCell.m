//
//  LibraryPanelTableViewCell.m
//  Eshiksa
//
//  Created by Punit on 27/04/18.
//  Copyright © 2018 Akhilesh. All rights reserved.
//

#import "LibraryPanelTableViewCell.h"

@implementation LibraryPanelTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _requestBtn.layer.masksToBounds=YES;
    _requestBtn.layer.cornerRadius=8.0;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
