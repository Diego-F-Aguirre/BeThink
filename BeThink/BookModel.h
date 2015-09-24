//
//  BookModel.h
//  BeThink
//
//  Created by Diego Aguirre on 9/21/15.
//  Copyright (c) 2015 Diego Aguirre. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BookModel : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *author;
@property (nonatomic, strong) NSString *imageURL;
@property (nonatomic, strong) NSNumber *bookId;
@property (nonatomic, strong) NSString *summary;
@property (nonatomic, strong) NSNumber *averageRating;

+ (BookModel *)bookFromDictionary:(NSDictionary *)dict;
+ (NSArray *)arrayFromDictionaryArray:(NSArray *)dictArray;
@end
