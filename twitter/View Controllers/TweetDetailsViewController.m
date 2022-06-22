//
//  TweetDetailsViewController.m
//  twitter
//
//  Created by Iris Fu on 6/22/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "TweetDetailsViewController.h"
#import "UIImageView+AFNetworking.h"
#import "APIManager.h"

@interface TweetDetailsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *profilePicture;
@property (weak, nonatomic) IBOutlet UILabel *screenName;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *tweetText;
@property (weak, nonatomic) IBOutlet UILabel *datePosted;
@property (weak, nonatomic) IBOutlet UILabel *retweetsCount;
@property (weak, nonatomic) IBOutlet UILabel *likesCount;
- (IBAction)didTapRetweet:(id)sender;
- (IBAction)didTapFavorite:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *retweetButton;
@property (weak, nonatomic) IBOutlet UIButton *favoriteButton;


@end

@implementation TweetDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // set the picture
    NSString *URLString = self.tweet.user.profilePicture;
    NSURL *url = [NSURL URLWithString:URLString];
    [self.profilePicture setImageWithURL:url];
    self.profilePicture.layer.cornerRadius = self.profilePicture.frame.size.width / 2; // display circular picture
    
    self.screenName.text = self.tweet.user.name;
    self.userName.text = [NSString stringWithFormat:@"@%@", self.tweet.user.screenName];
    self.tweetText.text = self.tweet.text;
    
    // set the datePosted
    self.datePosted.text = self.tweet.createdAtString;
    self.retweetsCount.text = @(self.tweet.retweetCount).stringValue;
    self.likesCount.text = @(self.tweet.favoriteCount).stringValue;
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)didTapFavorite:(id)sender {
    // Update the local tweet model
    if (self.tweet.favorited) { // user is unliking the tweet
        self.tweet.favoriteCount--;
        self.tweet.favorited = false;
        // Update cell UI
        [self refreshFavoritesData];
        // Send a POST request to the POST unfavorite endpoint
        [[APIManager shared] unfavorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
             if (error) {
                  NSLog(@"Error unfavoriting tweet: %@", error.localizedDescription);
             }
             else {
                 NSLog(@"Successfully unfavorited the following Tweet: %@", tweet.text);
             }
         }];
    } else { // user is liking the tweet
        self.tweet.favoriteCount++;
        self.tweet.favorited = true;
        // Update cell UI
        [self refreshFavoritesData];
        // Send a POST request to the POST favorite endpoint
        [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
             if (error) {
                  NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
             }
             else {
                 NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
             }
         }];
    }
}

- (void)refreshFavoritesData {
    self.likesCount.text = @(self.tweet.favoriteCount).stringValue;
    [self.favoriteButton setSelected:self.tweet.favorited];
}


- (IBAction)didTapRetweet:(id)sender {
    if (self.tweet.retweeted) { // user is unretweeting
        self.tweet.retweetCount--;
        self.tweet.retweeted = false;
        // refresh UI
        [self refreshRetweetsData];
        // Send a POST request to the POST unretweet endpoint
        [[APIManager shared] unretweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if (error) {
                 NSLog(@"Error unretweeting tweet: %@", error.localizedDescription);
            }
            else {
                NSLog(@"Successfully unretweeted the following Tweet: %@", tweet.text);
            }
        }];
    } else { // user is retweeting
        self.tweet.retweetCount++;
        self.tweet.retweeted = true;
        // refresh UI
        [self refreshRetweetsData];
        // Send a POST request to the POST retweet endpoint
        [[APIManager shared] retweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if (error) {
                 NSLog(@"Error retweeting tweet: %@", error.localizedDescription);
            }
            else {
                NSLog(@"Successfully retweeted the following Tweet: %@", tweet.text);
            }
        }];
    }
}

- (void)refreshRetweetsData {
    self.retweetsCount.text = @(self.tweet.retweetCount).stringValue;
    [self.retweetButton setSelected:self.tweet.retweeted];
}

@end
