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
#import "BTResultsDataSource.h"


@interface BookShelfCollectionViewController ()

@property (weak, nonatomic) IBOutlet UICollectionView *bookShelfCollectionView;
@property (strong, nonatomic) BTResultsDataSource *savedBooksDataSource;

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
    
    self.savedBooksDataSource = [BTResultsDataSource new];
    self.bookShelfCollectionView.dataSource = self.savedBooksDataSource;
    
    [self.bookShelfCollectionView registerNib:[UINib nibWithNibName:@"BTBookCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Register cell classes
//    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
}









@end
