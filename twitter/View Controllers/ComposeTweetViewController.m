//
//  ComposeTweetViewController.m
//  twitter
//
//  Created by Iris Fu on 6/21/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "ComposeTweetViewController.h"
#import "APIManager.h"

@interface ComposeTweetViewController ()
@property (weak, nonatomic) IBOutlet UITextView *composedTweetMessage;
- (IBAction)closeCompose:(id)sender;
- (IBAction)tweetComposedMessage:(id)sender;

@end

@implementation ComposeTweetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)tweetComposedMessage:(id)sender {
    [[APIManager shared] postStatusWithText:self.composedTweetMessage.text completion:^(Tweet *newTweet, NSError *error) {
        if (error) {
            NSLog(@"Encountered error posting tweet: %@", error.localizedDescription);
        } else {
            NSLog(@"Successfully tweeted: %@", self.composedTweetMessage.text);
            [self dismissViewControllerAnimated:true completion:nil];
        }
    }];
}

- (IBAction)closeCompose:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}
@end
