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

NSString *const bookDidGetSaved =@"bookDidGetSaved";

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
   
    PFObject *userBook = [PFObject objectWithClassName:@"UserBooks"];
    userBook[@"UserID"] = [PFUser currentUser];
    userBook[@"Title"] = newBook.title;
    userBook[@"Author"] = newBook.author;
    //userBook[@"Description"] = newBook.summary;
    userBook[@"Rating"] = newBook.averageRating;
    userBook[@"GoodRead_ID"] = newBook.bookId;
    userBook[@"CoverArt"] = newBook.imageURL;
    [userBook saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            // Fire NSNotificationCenter
            NSMutableArray *addedBooks = [userBook mutableCopy];
            self.savedBooks = addedBooks;
            
            [[NSNotificationCenter defaultCenter] postNotificationName:bookDidGetSaved object:userBook];
            
        } else {
            // There was a problem, check error.description
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sorry! Book not saved. Try again!" message:[error.userInfo objectForKey:@"error"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            
            [alertView show];
        }
    }];

}

@end
