//
//  BTDataSource.h
//  BeThink
//
//  Created by Diego Aguirre on 9/21/15.
//  Copyright (c) 2015 Diego Aguirre. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BookModel.h"
#import <Parse/Parse.h>

@interface BTDataSource : NSObject <UICollectionViewDataSource>

extern NSString *const bookDidGetSaved;

@property (strong, nonatomic) NSMutableArray *searchedBooks;
@property (strong, nonatomic) NSMutableArray *savedBooks;
@property (nonatomic, strong) PFObject *userBookShelf;

- (void)loadBooks:(NSString *)queryString completionBlock:(void (^)())completionBlock;
- (void)saveNewBook:(BookModel *)newBook;
+(instancetype) sharedInstance;

@end
