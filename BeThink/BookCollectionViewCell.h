//
//  BookCollectionViewCell.h
//  BeThink
//
//  Created by Diego Aguirre on 9/21/15.
//  Copyright (c) 2015 Diego Aguirre. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookModel.h"
#import "BTBookCollectionViewCell.h"

@interface BookCollectionViewCell : UICollectionViewCell

//@property (nonatomic, strong) BookModel *book;
//
- (void) setCellWithBook:(BookModel *)book;

@end
