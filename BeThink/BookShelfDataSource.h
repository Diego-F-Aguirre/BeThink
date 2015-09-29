//
//  BookShelfDataSource.h
//  BeThink
//
//  Created by Diego Aguirre on 9/29/15.
//  Copyright © 2015 Diego Aguirre. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BookShelfDataSource : NSObject <UICollectionViewDataSource>

@property (strong, nonatomic) NSMutableArray *books;

@end
