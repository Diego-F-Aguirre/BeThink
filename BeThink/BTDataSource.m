//
//  BTDataSource.m
//  BeThink
//
//  Created by Diego Aguirre on 9/21/15.
//  Copyright (c) 2015 Diego Aguirre. All rights reserved.
//

#import "BTDataSource.h"
#import "BTAPIClient.h"
#import "BTBookCollectionViewCell.h"

@implementation BTDataSource

+ (instancetype) sharedInstance {
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self)
    {
        self.searchedBooks = [@[] mutableCopy];
        self.savedBooks = [@[] mutableCopy];
    }
    return self;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BTBookCollectionViewCell * cell = (BTBookCollectionViewCell *) [collectionView dequeueReusableCellWithReuseIdentifier:@"BookCell" forIndexPath:indexPath];
    [cell setCellWithBook:self.searchedBooks[indexPath.item]];
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    switch (section) {
    case 0:
        return self.searchedBooks.count;
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
        self.searchedBooks = newBooks;
        completionBlock();
        
    }];
}

- (void)saveNewBook:(BookModel *)newBook {
    // add new book to parse
    // add to savedBooks
    // do that here
    
    self.userBookShelf = [PFObject objectWithClassName:@"UserBooks"];
    NSData *bookData = UIImagePNGRepresentation([UIImage imageNamed:newBook.imageURL]);
    PFFile *savedBookFile = [PFFile fileWithData:bookData];
    
    [self.userBookShelf setObject:savedBookFile forKey:@"UserBooks"];
    
    
    [self.userBookShelf saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (error) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sorry! Book not saved. Try again!" message:[error.userInfo objectForKey:@"error"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            
            [alertView show];
        }
    }];
}

@end
