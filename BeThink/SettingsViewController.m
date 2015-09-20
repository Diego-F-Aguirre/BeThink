//
//  SettingsViewController.m
//  BeThink
//
//  Created by Diego Aguirre on 9/17/15.
//  Copyright (c) 2015 Diego Aguirre. All rights reserved.
//

#import "SettingsViewController.h"
#import <Parse/Parse.h>
#import "GROAuth.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)logout:(id)sender {
    
    [PFUser logOut];
    [self performSegueWithIdentifier:@"showLogin" sender:self];
    
    [GROAuth loginWithGoodreadsWithCompletion:^(NSDictionary *authParams, NSError *error) {
        if (error) {
            UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"Sorry!" message:[error.userInfo objectForKey:@"error"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            
            [alertview show];
        }
        else{
            
            NSURLRequest *username = [GROAuth goodreadsRequestForOAuthPath:@"api/auth_user" parameters:nil HTTPmethod:@"GET"];
            username = nil;
//            NSHTTPURLResponse* urlResponse = nil;
//            NSError *urlError = [[NSError alloc] init];
//            NSData *responseData = [NSURLConnection sendSynchronousRequest:username returningResponse:&urlResponse error:&urlError];
//            NSString *result = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
//            NSLog(@"result: %@", result);
            
            [self performSegueWithIdentifier:@"showLogin" sender:self];
        }
    }];
}

//- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
//    if ([segue.identifier isEqualToString:@"showLogin"]) {
//        [segue.destinationViewController setHidesBottomBarWhenPushed:YES];
//    }
//}








@end
