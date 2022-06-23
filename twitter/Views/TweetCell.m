//
//  TweetCell.m
//  twitter
//
//  Created by Iris Fu on 6/20/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "APIManager.h"
#import "UIImageView+AFNetworking.h"

@implementation TweetCell
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
    [self.favoriteButton setTitle:[NSString stringWithFormat:@"%d",self.tweet.favoriteCount] forState:UIControlStateNormal];
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
    [self.retweetButton setTitle:[NSString stringWithFormat:@"%d", self.tweet.retweetCount] forState:UIControlStateNormal];
    [self.retweetButton setSelected:self.tweet.retweeted];
}

- (IBAction)didTapReply:(id)sender {
    self.tweet.replyCount++;
    self.tweet.replied = true;
    // refresh UI
    [self refreshReplyData];
}

- (void)refreshReplyData {
    [self.replyButton setTitle:[NSString stringWithFormat:@"%d", self.tweet.replyCount] forState:UIControlStateNormal];
    [self.replyButton setSelected:self.tweet.replied];
}


@end
