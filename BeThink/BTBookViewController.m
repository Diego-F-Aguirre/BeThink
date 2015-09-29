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
    
    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showBookInShelf"]) {
        BookModel *book = sender;
        BookShelfCollectionViewController *dest = (BookShelfCollectionViewController *)segue.destinationViewController;
        dest.book = book;
    }
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
