//
//  BTResultsDataSource.h
//  BeThink
//
//  Created by Diego Aguirre on 9/21/15.
//  Copyright (c) 2015 Diego Aguirre. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BTResultsDataSource : NSObject <UICollectionViewDataSource>

@property (strong, nonatomic) NSMutableArray *books;

- (void)loadBooks:(NSString *)queryString completionBlock:(void (^)())completionBlock;

@end
