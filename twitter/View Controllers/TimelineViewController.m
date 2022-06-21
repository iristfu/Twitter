//
//  TimelineViewController.m
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TimelineViewController.h"
#import "APIManager.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "TweetCell.h"
#import "Tweet.h"
#import "UIImageView+AFNetworking.h"
#import "ComposeTweetViewController.h"

@interface TimelineViewController () <ComposeTweetViewControllerDelegate, UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *twitterFeedTableView;
- (IBAction)didTapLogout:(id)sender;
@property (strong, nonatomic) NSMutableArray* arrayOfTweets;
@property (strong,nonatomic)  UIRefreshControl *refreshControl;

@end

@implementation TimelineViewController

- (void)fetchTweets {
    [[APIManager shared] getHomeTimelineWithCompletion:^(NSMutableArray *tweets, NSError *error) {
        if (tweets) {
            NSLog(@"😎😎😎 Successfully loaded home timeline");
            self.arrayOfTweets = tweets;
            NSLog(@"Here is the arrray of tweets: %@", self.arrayOfTweets);
            [self.twitterFeedTableView reloadData];
        } else {
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
        }
        // Tell the refreshControl to stop spinning
        [self.refreshControl endRefreshing];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Initialize a UIRefreshControl
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchTweets) forControlEvents:UIControlEventValueChanged];
    [self.twitterFeedTableView insertSubview:self.refreshControl atIndex:0];
    
    self.twitterFeedTableView.dataSource = self;
    self.twitterFeedTableView.delegate = self;
    self.twitterFeedTableView.rowHeight = UITableViewAutomaticDimension;
    
    // Get timeline
    [self fetchTweets];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
   UINavigationController *navigationController = [segue destinationViewController];
   ComposeTweetViewController *composeTweetController = (ComposeTweetViewController*)navigationController.topViewController;
   composeTweetController.delegate = self;
}



- (IBAction)didTapLogout:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    appDelegate.window.rootViewController = loginViewController;
    
    [[APIManager shared] logout];
}
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    Tweet *tweet = self.arrayOfTweets[indexPath.row];
    TweetCell *tweetCell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell" forIndexPath:indexPath];
    tweetCell.tweet = tweet;
    // set tweet profile picture
    NSString *URLString = tweet.user.profilePicture;
    NSURL *url = [NSURL URLWithString:URLString];
    [tweetCell.profilePicture setImageWithURL:url];
    
    // set other metadata for tweet
    tweetCell.screenName.text = tweet.user.name;
    tweetCell.tweetText.text = tweet.text;
    NSLog(@"The tweet text should be: %@", tweet.text);
    tweetCell.userName.text = [NSString stringWithFormat:@"@%@", tweet.user.screenName];
    tweetCell.datePosted.text = tweet.createdAtString;
    [tweetCell.replyButton setTitle:[NSString stringWithFormat:@"%d", tweet.replyCount] forState:UIControlStateNormal];
    [tweetCell.favoriteButton setTitle:[NSString stringWithFormat:@"%d",tweet.favoriteCount] forState:UIControlStateNormal];
    [tweetCell.retweetButton setTitle:[NSString stringWithFormat:@"%d", tweet.retweetCount] forState:UIControlStateNormal];
    
    return tweetCell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayOfTweets.count;
}


- (void)didTweet:(nonnull Tweet *)tweet {
    [self.arrayOfTweets insertObject:tweet atIndex:0];
    [self.twitterFeedTableView reloadData];
}

@end
