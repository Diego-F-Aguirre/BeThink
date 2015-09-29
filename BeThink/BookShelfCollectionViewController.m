//
//  BookShelfCollectionViewController.m
//  BeThink
//
//  Created by Diego Aguirre on 9/16/15.
//  Copyright (c) 2015 Diego Aguirre. All rights reserved.
//

#import "BookShelfCollectionViewController.h"
#import <Parse/Parse.h>
#import "BTBookViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>




@interface BookShelfCollectionViewController ()

@end

@implementation BookShelfCollectionViewController

static NSString * const reuseIdentifier = @"BookCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    PFUser *currentUser = [PFUser currentUser];
    
    if (currentUser) {
        NSLog(@"Current user: %@", currentUser.username);
    } else {
        [self performSegueWithIdentifier:@"showLogin" sender:self];
    }
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"BTBookCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Register cell classes
//    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setCellWithBook:(BookModel *)book {
    self.book = book;
    [self.bookCover sd_setImageWithURL:[NSURL URLWithString:book.imageURL]];
}







@end
