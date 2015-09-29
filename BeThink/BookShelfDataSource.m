//
//  BookShelfDataSource.m
//  BeThink
//
//  Created by Diego Aguirre on 9/29/15.
//  Copyright © 2015 Diego Aguirre. All rights reserved.
//

#import "BookShelfDataSource.h"
#import "BookCollectionViewCell.h"

@implementation BookShelfDataSource

- (instancetype)init {
    self = [super init];
    if (self)
    {
        self.books = [@[] mutableCopy];
    }
    return self;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BookCollectionViewCell * cell = (BookCollectionViewCell *) [collectionView dequeueReusableCellWithReuseIdentifier:@"BookCell" forIndexPath:indexPath];
    [cell setCellWithBook:self.books[indexPath.item]];
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return self.books.count;
            break;
        default:
            return 0;
    }
}

@end
