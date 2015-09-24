//
//  BTAPIClient.m
//  BeThink
//
//  Created by Diego Aguirre on 9/21/15.
//  Copyright (c) 2015 Diego Aguirre. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import <XMLDictionary/XMLDictionary.h>
#import "BTAPIClient.h"
#import "BookModel.h"

#define DEVELOPER_KEY @"aUO5nxC6zKts3EbC7qxTw"
#define BASE_URL @"https://www.goodreads.com/"

@interface BTAPIClient ()

@property (strong, nonatomic) AFHTTPRequestOperationManager *manager;

@end

@implementation BTAPIClient

+ (id)sharedManager {
    static BTAPIClient *sharedMyManager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    
    return sharedMyManager;
}

- (id)init {
    if (self = [super init]) {
        self.manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:BASE_URL]];
        self.manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
    }
    return self;
}

- (void)searchWithQuery:(NSString *)query completionBlock:(void (^)(BOOL success, NSArray *results))completionBlock {

    [self.manager GET:@"search.xml" parameters:@{@"q": query, @"key": DEVELOPER_KEY} success:^(AFHTTPRequestOperation *operation, NSXMLParser *xmlParser) {
        NSDictionary *resultDict = [NSDictionary dictionaryWithXMLParser:xmlParser];
        completionBlock(true, [BookModel arrayFromDictionaryArray:resultDict[@"search"][@"results"][@"work"]]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        completionBlock(false, nil);
    }];
}

@end
