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
        [self fetchUserBookCollection];
    }
    return self;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BTBookCollectionViewCell * cell = (BTBookCollectionViewCell *) [collectionView dequeueReusableCellWithReuseIdentifier:@"BookCell" forIndexPath:indexPath];
    //[cell setCellWithBook:self.searchedBooks[indexPath.item]];
    
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//    switch (section) {
//        case 0:
//            return 0; //self.searchedBooks.count;
//            break;
//        default:
//            return 0;
//    }
    return self.bookArray.count;
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

- (void)fetchUserBookCollection {
    PFQuery *query = [PFQuery queryWithClassName:@"UserBooks"];
    [query whereKey:@"UserID" equalTo:[PFUser currentUser]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %lu scores.", (unsigned long)objects.count);
            // Do something with the found objects
            for (PFObject *object in objects) {
                NSLog(@"%@", object.objectId);
                //if object exists then skip
                //[self.savedBooks addObject:object];
            }
            [self.savedBooks addObjectsFromArray:objects];
            [[NSNotificationCenter defaultCenter] postNotificationName:bookDidGetSaved object:nil];
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
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

    
    PFQuery *checkUserBookQuery = [PFQuery queryWithClassName:@"UserBooks"];
    [checkUserBookQuery whereKey:@"UserID" equalTo:userBook[@"UserID"]];
    [checkUserBookQuery whereKey:@"GoodRead_ID" equalTo:userBook[@"GoodRead_ID"]];
    
    [checkUserBookQuery countObjectsInBackgroundWithBlock:^(int number, NSError * _Nullable error) {
        if (error){
            NSLog(@"Network error");
        }
        else if (number == 0) {
            //add new user book
            [self makeSaveNewBookRequest:userBook];
        }
        else if (number > 0) {
            NSLog(@"User already has this book");
        }
    
        
    }];
    
//    
//    [checkUserBookQuery getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
//        if(!error && object == nil) {
//            //ADD NEW USER BOOK
//            [self makeSaveNewBookRequest:userBook];
//            
//        }
//        else if (error) {
//            //SOME NETWORK ERROR
//            NSLog(@"Network error");
//        }
//        else if (object){
//            //USERBOOK aldready exist
//            NSLog(@"User already has this book");
//        }
//        else {
//            
//        }
//    }];
    
    

}


- (void)makeSaveNewBookRequest:(PFObject *)userBook {
    [userBook saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        
        if (succeeded) {

            [self fetchUserBookCollection];
        } else {
            // There was a problem, check error.description
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sorry! Book not saved. Try again!" message:[error.userInfo objectForKey:@"error"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            
            [alertView show];
        }
    }];
}

@end
