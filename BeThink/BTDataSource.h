//
//  BTDataSource.h
//  BeThink
//
//  Created by Diego Aguirre on 9/21/15.
//  Copyright (c) 2015 Diego Aguirre. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BTDataSource : NSObject <UICollectionViewDataSource>

@property (strong, nonatomic) NSMutableArray *searchedBooks;
@property (strong, nonatomic) NSMutableArray *savedBooks;

- (void)loadBooks:(NSString *)queryString completionBlock:(void (^)())completionBlock;
+(instancetype) sharedInstance;

@end
