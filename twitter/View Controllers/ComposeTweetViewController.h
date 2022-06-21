//
//  ComposeTweetViewController.h
//  twitter
//
//  Created by Iris Fu on 6/21/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ComposeTweetViewControllerDelegate
- (void)didTweet:(Tweet *)tweet;

@end

@interface ComposeTweetViewController : UIViewController
@property (nonatomic, weak) id<ComposeTweetViewControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
