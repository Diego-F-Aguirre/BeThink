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
#import "BTSearchViewController.h"
#import "BTDataSource.h"
#import "BookCollectionViewCell.h"


@interface BookShelfCollectionViewController ()

@property (weak, nonatomic) IBOutlet UICollectionView *bookShelfCollectionView;

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
    
    self.bookShelfCollectionView.dataSource = self;
    
    [self.bookShelfCollectionView registerNib:[UINib nibWithNibName:@"BTBookCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    

}


- (void) viewDidAppear:(BOOL)animated{
//    [self.bookShelfCollectionView reloadData];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:bookDidGetSaved object:nil queue:nil usingBlock:^(NSNotification *book) {
        
        //[BTDataSource sharedInstance].savedBooks = book.object;
        NSLog(@"reload table about to fire");
        [self.bookShelfCollectionView reloadData];
    }];
    
    [[NSNotificationCenter defaultCenter] removeObserver:bookDidGetSaved name:nil object:nil];
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    BTDataSource *dataSource = [BTDataSource sharedInstance];
    
    PFQuery *query = [PFQuery queryWithClassName:@"UserBooks"];
    NSString *objectId = dataSource.userBookShelf.objectId;
    [query getObjectInBackgroundWithId:objectId block:^(PFObject *object, NSError *error) {
        //dataSource saveNewBook:dataSource.userBookShelf.objectId];
    }];
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BookCollectionViewCell * cell = (BookCollectionViewCell *) [collectionView dequeueReusableCellWithReuseIdentifier:@"BookCell" forIndexPath:indexPath];
    [cell setCellWithBook: [BTDataSource sharedInstance].savedBooks[indexPath.item]];
    
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return [BTDataSource sharedInstance].savedBooks.count;
            break;
        default:
            return 0;
    }

}


@end
