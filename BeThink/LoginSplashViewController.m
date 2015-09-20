//
//  LoginSplashViewController.m
//  BeThink
//
//  Created by Diego Aguirre on 9/17/15.
//  Copyright (c) 2015 Diego Aguirre. All rights reserved.
//

#import "LoginSplashViewController.h"
#import "GROAuth.h"

@interface LoginSplashViewController ()

@end

@implementation LoginSplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (!self.navigationItem.hidesBackButton) {
        self.navigationItem.hidesBackButton = YES;
    }
    else {
        NSLog(@"back button already hidden");
    }
}


- (IBAction)login:(id)sender {
    
   
  
        [GROAuth loginWithGoodreadsWithCompletion:^(NSDictionary *authParams, NSError *error) {
            if (error) {
                UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"Sorry!" message:[error.userInfo objectForKey:@"error"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                
                [alertview show];
            }
            else{
                
                NSURLRequest *username = [GROAuth goodreadsRequestForOAuthPath:@"api/auth_user" parameters:nil HTTPmethod:@"GET"];
                NSHTTPURLResponse* urlResponse = nil;
                NSError *urlError = [[NSError alloc] init];
                NSData *responseData = [NSURLConnection sendSynchronousRequest:username returningResponse:&urlResponse error:&urlError];
                NSString *result = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
                NSLog(@"result: %@", result);
                
                            NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:@"46149571",@"id",[GROAuth consumerKey],@"key", nil];
                            NSString *result2 = [GROAuth XMLResponseForNonOAuthPath:@"user/show" parameters:parameters];
                            NSLog(@"result: %@", result2);
                
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
        }];
}

- (BOOL) hidesBottomBarWhenPushed
{
    return (self.navigationController.topViewController == self);
}

@end
