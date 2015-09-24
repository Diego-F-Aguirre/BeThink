//
//  BTBookCollectionViewCell.h
//  BeThink
//
//  Created by Diego Aguirre on 9/21/15.
//  Copyright (c) 2015 Diego Aguirre. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookModel.h"

@interface BTBookCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) BookModel *book;
@property (strong, nonatomic) IBOutlet UIImageView *bookCover;
- (void) setCellWithBook:(BookModel *)book;
@end
