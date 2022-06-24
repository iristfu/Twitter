//
//  MentionsViewController.m
//  twitter
//
//  Created by Iris Fu on 6/23/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "MentionsViewController.h"
#import "APIManager.h"
#import "TweetCell.h"
#import "TweetDetailsViewController.h"
#import "UIImageView+AFNetworking.h"

@interface MentionsViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *mentionsTableView;
@property (strong, nonatomic) NSMutableArray* arrayOfTweets;
@property (nonatomic, strong) User *loggedInUser;

@end

@implementation MentionsViewController

- (void)getMentions {
    [[APIManager shared] getMentions:^(NSMutableArray *mentions, NSError *error) {
        if (mentions) {
            NSLog(@"😎😎😎 Successfully loaded mentions");
            self.arrayOfTweets = mentions;
            NSLog(@"Here is the array of mentions: %@", self.arrayOfTweets);
            [self.mentionsTableView reloadData];
        } else {
            NSLog(@"😫😫😫 Error getting mentions: %@", error.localizedDescription);
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mentionsTableView.dataSource = self;
    self.mentionsTableView.delegate = self;
    self.mentionsTableView.rowHeight = UITableViewAutomaticDimension;
    
    [self getMentions];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    Tweet *tweet = self.arrayOfTweets[indexPath.row];
    TweetCell *tweetCell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell" forIndexPath:indexPath];
    tweetCell.delegate = self;
    tweetCell.tweet = tweet;
    // set tweet profile picture
    NSString *URLString = tweet.user.profilePicture;
    NSURL *url = [NSURL URLWithString:URLString];
    [tweetCell.profilePicture setImageWithURL:url];
    tweetCell.profilePicture.layer.cornerRadius = tweetCell.profilePicture.frame.size.width / 2;
    
    // set other metadata for tweet
    tweetCell.screenName.text = tweet.user.name;
    tweetCell.tweetText.text = tweet.text;
    NSLog(@"The tweet text should be: %@", tweet.text);
    tweetCell.userName.text = [NSString stringWithFormat:@"@%@", tweet.user.screenName];
    tweetCell.datePosted.text = tweet.createdAtSinceNowString;
    [tweetCell.replyButton setTitle:[NSString stringWithFormat:@"%d", tweet.replyCount] forState:UIControlStateNormal];
    [tweetCell.favoriteButton setTitle:[NSString stringWithFormat:@"%d",tweet.favoriteCount] forState:UIControlStateNormal];
    [tweetCell.retweetButton setTitle:[NSString stringWithFormat:@"%d", tweet.retweetCount] forState:UIControlStateNormal];
    
    return tweetCell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayOfTweets.count;
}

@end
