//
//  BTBookViewController.h
//  BeThink
//
//  Created by Diego Aguirre on 9/23/15.
//  Copyright © 2015 Diego Aguirre. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookModel.h"

@interface BTBookViewController : UIViewController

@property (strong, nonatomic) BookModel *book;
@property (weak, nonatomic) IBOutlet UIImageView *bookCover;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;
@property (weak, nonatomic) IBOutlet UITextView *bookDescription;


- (IBAction)addBook:(id)sender;

@end
