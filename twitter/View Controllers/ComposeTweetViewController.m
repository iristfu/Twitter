//
//  ComposeTweetViewController.m
//  twitter
//
//  Created by Iris Fu on 6/21/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "ComposeTweetViewController.h"
#import "APIManager.h"
#import "RSKPlaceholderTextView/RSKPlaceholderTextView-umbrella.h"
#import "TweetCell.h"

@interface ComposeTweetViewController ()
@property (weak, nonatomic) IBOutlet UILabel *replyingToLabel;
@property (weak, nonatomic) IBOutlet UITextView *composedTweetMessage;
@property (weak, nonatomic) IBOutlet UILabel *characterCount;
- (IBAction)closeCompose:(id)sender;
- (IBAction)tweetComposedMessage:(id)sender;

@end

@implementation ComposeTweetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.composedTweetMessage.delegate = self;
    self.characterCount.text = [NSString stringWithFormat:@"%lu / 140", (unsigned long)self.composedTweetMessage.text.length];
    
    // If replying to another tweet, show who the user is replying to
    if (self.originalTweet) {
        self.replyingToLabel.text = [NSString stringWithFormat: @"Replying to @%@", self.originalTweet.user.screenName];
        self.composedTweetMessage.text = [NSString stringWithFormat:@"Tweet your reply"];
    } else {
        self.replyingToLabel.text = [NSString stringWithFormat:@""];
    }
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    // Set the max character limit
    int characterLimit = 140;

    // Construct what the new text would be if we allowed the user's latest edit
    NSString *newText = [self.composedTweetMessage.text stringByReplacingCharactersInRange:range withString:text];

    // Update character count label
    self.characterCount.text = [NSString stringWithFormat:@"%lu / %u", (unsigned long)newText.length, characterLimit];

    // Should the new text should be allowed? True/False
    return newText.length < characterLimit;
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
    if (!self.originalTweet) { // originalTweet is empty, so user is creating a new tweet
        [[APIManager shared] postStatusWithText:self.composedTweetMessage.text completion:^(Tweet *newTweet, NSError *error) {
            if (error) {
                NSLog(@"Encountered error posting tweet: %@", error.localizedDescription);
            } else {
                NSLog(@"Successfully tweeted: %@", self.composedTweetMessage.text);
                [self.delegate didTweet:newTweet];
                [self dismissViewControllerAnimated:true completion:nil];
            }
        }];
    } else { // originalTweet has content, so user is responding to a tweet
        [[APIManager shared] postReply:self.composedTweetMessage.text : self.originalTweet.idStr completion:^(Tweet *reply, NSError *error) {
            if(error) {
                NSLog(@"Encountered error responding to tweet: %@", error.localizedDescription);
            }
            else {
                NSLog(@"Successfully responded to a tweet!");
                [self.delegate didTweet:reply];
                [self dismissViewControllerAnimated:true completion:nil];
            }
        }];
    }
}

- (IBAction)closeCompose:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}
@end
