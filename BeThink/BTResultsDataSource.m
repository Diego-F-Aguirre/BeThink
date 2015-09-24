//
//  BTResultsDataSource.m
//  BeThink
//
//  Created by Diego Aguirre on 9/21/15.
//  Copyright (c) 2015 Diego Aguirre. All rights reserved.
//

#import "BTResultsDataSource.h"
#import "BTAPIClient.h"
#import "BTBookCollectionViewCell.h"

@implementation BTResultsDataSource

- (instancetype)init {
    self = [super init];
    if (self)
    {
        self.books = [@[] mutableCopy];
    }
    return self;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BTBookCollectionViewCell * cell = (BTBookCollectionViewCell *) [collectionView dequeueReusableCellWithReuseIdentifier:@"BookCell" forIndexPath:indexPath];
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

- (void)loadBooks:(NSString *)queryString completionBlock:(void (^)())completionBlock {
    [[BTAPIClient sharedManager] searchWithQuery:queryString completionBlock:^(BOOL success, NSArray *results) {
        NSMutableArray *newBooks = [@[] mutableCopy];
        if (success && results) {
            newBooks = [results mutableCopy];
        }
        self.books = newBooks;
        completionBlock();
        
    }];
}

@end
