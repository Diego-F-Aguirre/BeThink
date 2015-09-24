//
//  BTBookViewController.m
//  BeThink
//
//  Created by Diego Aguirre on 9/23/15.
//  Copyright © 2015 Diego Aguirre. All rights reserved.
//

#import "BTBookViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface BTBookViewController ()

@end

@implementation BTBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.bookCover sd_setImageWithURL:[NSURL URLWithString:self.book.imageURL]];
    self.titleLabel.text = self.book.title;
    self.authorLabel.text = self.book.author;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
