//
//  BTAPIClient.h
//  BeThink
//
//  Created by Diego Aguirre on 9/21/15.
//  Copyright (c) 2015 Diego Aguirre. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BTAPIClient : NSObject <NSXMLParserDelegate>

+ (instancetype)sharedManager;

- (void) searchWithQuery:(NSString *)query completionBlock:(void (^)(BOOL success, NSArray *results))completionBlock;

@end
