//
//  BTBookViewController.m
//  BeThink
//
//  Created by Diego Aguirre on 9/23/15.
//  Copyright © 2015 Diego Aguirre. All rights reserved.
//

#import "BTBookViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "BookShelfCollectionViewController.h"
#import "BTDataSource.h"


@interface BTBookViewController ()

@end

@implementation BTBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.bookCover sd_setImageWithURL:[NSURL URLWithString:self.book.imageURL]];
    self.titleLabel.text = self.book.title;
    self.authorLabel.text = self.book.author;
//    self.bookDescription.text = self.book.summary;
    NSString *ratingText = @"Rating: ";
    NSString *ratingScore = [self.book.averageRating stringValue];
    self.ratingLabel.text = [ratingText stringByAppendingString:ratingScore];
}

- (IBAction)addBook:(id)sender {
    
    [[BTDataSource sharedInstance].savedBooks addObject: self.book];
//    [[BTDataSource sharedInstance] saveNewBook:self.book];
    //wait for completion
    
}




@end
