//
//  BTSearchViewController.m
//  BeThink
//
//  Created by Diego Aguirre on 9/21/15.
//  Copyright (c) 2015 Diego Aguirre. All rights reserved.
//

#import "BTSearchViewController.h"
#import "BTResultsDataSource.h"
#import "BookModel.h"
#import "BTBookViewController.h"

@interface BTSearchViewController ()

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (weak, nonatomic) IBOutlet UICollectionView *resultsCollectionView;

@property (strong, nonatomic) BTResultsDataSource *resultsDataSource;

@end

@implementation BTSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.resultsDataSource = [BTResultsDataSource new];
    // Do any additional setup after loading the view.
    self.resultsCollectionView.dataSource = self.resultsDataSource;
    [self.resultsCollectionView registerNib:[UINib nibWithNibName:@"BTBookCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"BookCell"];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    [self performSegueWithIdentifier:@"showBookFromSearch" sender:self.resultsDataSource.books[indexPath.item]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {

    NSString *query = searchBar.text;
    [self.resultsDataSource loadBooks:query completionBlock:^{
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
