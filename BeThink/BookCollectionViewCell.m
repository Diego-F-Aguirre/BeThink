//
//  BookCollectionViewCell.m
//  BeThink
//
//  Created by Diego Aguirre on 9/21/15.
//  Copyright (c) 2015 Diego Aguirre. All rights reserved.
//

#import "BookCollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation BookCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setCellWithBook:(BookModel *)book {
    BTBookCollectionViewCell *reUseCell = [BTBookCollectionViewCell new];
    reUseCell.book = book;
    [reUseCell.bookCover sd_setImageWithURL:[NSURL URLWithString:book.imageURL]];
}

@end
