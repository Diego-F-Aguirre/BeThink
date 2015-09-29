//
//  BTBookCollectionViewCell.m
//  BeThink
//
//  Created by Diego Aguirre on 9/21/15.
//  Copyright (c) 2015 Diego Aguirre. All rights reserved.
//

#import "BTBookCollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation BTBookCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setCellWithBook:(BookModel *)book {
    self.book = book;
    [self.bookCover sd_setImageWithURL:[NSURL URLWithString:book.imageURL]];
}


@end
