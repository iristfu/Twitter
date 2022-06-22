//
//  TweetDetailsViewController.m
//  twitter
//
//  Created by Iris Fu on 6/22/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "TweetDetailsViewController.h"
#import "UIImageView+AFNetworking.h"

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
}

- (IBAction)didTapRetweet:(id)sender {
}
@end
