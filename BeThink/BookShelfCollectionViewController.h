//
//  BookShelfCollectionViewController.h
//  BeThink
//
//  Created by Diego Aguirre on 9/16/15.
//  Copyright (c) 2015 Diego Aguirre. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BTBookCollectionViewCell.h"

@interface BookShelfCollectionViewController : UICollectionViewController

@property (nonatomic, strong) BookModel *book;
@property (strong, nonatomic) IBOutlet UIImageView *bookCover;

@end
