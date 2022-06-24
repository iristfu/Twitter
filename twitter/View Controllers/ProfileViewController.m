//
//  ProfileViewController.m
//  twitter
//
//  Created by Iris Fu on 6/23/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "ProfileViewController.h"
#import "UIImageView+AFNetworking.h"
#import "APIManager.h"

@interface ProfileViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *profilePicture;
@property (weak, nonatomic) IBOutlet UILabel *screenName;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *bio;
@property (weak, nonatomic) IBOutlet UILabel *followingCount;
@property (weak, nonatomic) IBOutlet UILabel *followerCount;
@property (weak, nonatomic) IBOutlet UILabel *tweetCount;
@property (weak, nonatomic) IBOutlet UIImageView *headerPicture;

@end

@implementation ProfileViewController

- (void)displayUserProfile {
    // set the profile picture
    NSString *profileURLString = self.user.profilePicture;
    NSURL *profileURL = [NSURL URLWithString:profileURLString];
    [self.profilePicture setImageWithURL:profileURL];
    self.profilePicture.layer.cornerRadius = self.profilePicture.frame.size.width / 2; // display circular picture
    
    // set the header picture
    NSString *headerURLString = self.user.headerPicture;
    NSURL *headerURL = [NSURL URLWithString:headerURLString];
    [self.headerPicture setImageWithURL:headerURL];
    
    self.screenName.text = self.user.name;
    self.userName.text = [NSString stringWithFormat:@"@%@", self.user.screenName]; // I messed the naming up lol; fix later
    self.bio.text = self.user.bio;
    
    NSLog(@"Successfully got everything before the count labels");
    NSLog(@"Printing the follower count %@", self.user.followerCount);
    self.followerCount.text = self.user.followerCount;
    NSLog(@"Printing the following count %@", self.user.followingCount);
    self.followingCount.text = self.user.followingCount;
    NSLog(@"Printing the tweet count %@", self.user.tweetCount);
    self.tweetCount.text = self.user.tweetCount;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"Loading profile view screen");
    if (!self.user) {
        [[APIManager shared] getAccountDetails:^(User *user, NSError *error) {
            if (user) {
                self.user = user;
                // need the following code here as well because APIManager creates a diff thread
                NSLog(@"Got user details");
                [self displayUserProfile];
            } else {
                NSLog(@"😫😫😫 Error getting account details: %@", error.localizedDescription);
            }
        }];
    }
    NSLog(@"Got user details");
    [self displayUserProfile];
}

@end
