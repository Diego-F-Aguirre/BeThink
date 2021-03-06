//
//  BookModel.m
//  BeThink
//
//  Created by Diego Aguirre on 9/21/15.
//  Copyright (c) 2015 Diego Aguirre. All rights reserved.
//

#import "BookModel.h"

@implementation BookModel


+ (NSString*)parseClassName {
    return @"UserBooks";
}

//- (instancetype)init {
//    self = [super init];
//    if (self) {
//        self.bookId = @(0);
//        self.title = @"";
//        self.author = @"";
//        self.imageURL = @"";
//        self.summary = @"";
//        self.averageRating = @0;
//    }
//    return self;
//}

+ (BookModel *)bookFromDictionary:(NSDictionary *)dict {
    BookModel *book = [BookModel new];
    
    if (dict[@"average_rating"] && [dict[@"average_rating"] isKindOfClass:[NSString class]]) {
        book.averageRating = @([dict[@"average_rating"] floatValue]);
    }
    
    
    if (dict[@"best_book"][@"title"]) {
        book.title = dict[@"best_book"][@"title"];
    }
    
    
    if (dict[@"best_book"][@"author"][@"name"]) {
        book.author = dict[@"best_book"][@"author"][@"name"];
    }
    
    if (dict[@"best_book"][@"image_url"]) {
        book.imageURL = dict[@"best_book"][@"image_url"];
        book[@"CoverArt"] = dict[@"best_book"][@"image_url"];
    }
    
    if (dict[@"id"][@"__text"]) {
        book.bookId = dict[@"id"][@"__text"];
    }
    
    //Currently incorrect. Waiting on GR forum response
    if (dict[@"description"]) {
        book.summary = dict[@"description"];
    }
    
    
    return book;
}

+ (NSArray *)arrayFromDictionaryArray:(NSArray *)dictArray
{
    NSMutableArray *booksArray = [@[] mutableCopy];
    for (NSDictionary *book in dictArray)
    {
        [booksArray addObject:[BookModel bookFromDictionary:book]];
    }
    return booksArray;
}


- (NSString *)imageURL{
    return self[@"CoverArt"];
}

//- (NSString *)title {
//    return self[@"Title"];
//}

@end
