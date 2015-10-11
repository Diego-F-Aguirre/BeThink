//
//  BTSearchViewController.m
//  BeThink
//
//  Created by Diego Aguirre on 9/21/15.
//  Copyright (c) 2015 Diego Aguirre. All rights reserved.
//

#import "BTSearchViewController.h"
#import "BTDataSource.h"
#import "BookModel.h"
#import "BTBookViewController.h"
#import "BTBookCollectionViewCell.h"

@interface BTSearchViewController () 

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (weak, nonatomic) IBOutlet UICollectionView *resultsCollectionView;

@property (strong, nonatomic) BTDataSource *resultsDataSource;

@property (strong, nonatomic) NSArray *searchedBooks;

@end

@implementation BTSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.resultsDataSource = [BTDataSource new];
    // Do any additional setup after loading the view.
    //self.resultsCollectionView.dataSource = self.resultsDataSource;
    [self.resultsCollectionView registerNib:[UINib nibWithNibName:@"BTBookCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"BookCell"];
    self.resultsCollectionView.dataSource = self;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BTBookCollectionViewCell * cell = (BTBookCollectionViewCell *) [collectionView dequeueReusableCellWithReuseIdentifier:@"BookCell" forIndexPath:indexPath];
    [cell setCellWithBook:self.searchedBooks[indexPath.item]];
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.searchedBooks.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    [self performSegueWithIdentifier:@"showBookFromSearch" sender:self.searchedBooks[indexPath.item]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {

    NSString *query = searchBar.text;
    [[BTDataSource sharedInstance] loadBooks:query completionBlock:^{
        self.searchedBooks = [BTDataSource sharedInstance].searchedBooks;
        [self.resultsCollectionView reloadData];
    }];
    
    [searchBar resignFirstResponder];
}


#pragma mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showBookFromSearch"]) {
        BookModel *book = sender;
        BTBookViewController *dest = (BTBookViewController *)segue.destinationViewController;
        dest.book = book;
    }
    
}


@end
