//
//  TweetDetailsViewController.h
//  twitter
//
//  Created by Iris Fu on 6/22/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

NS_ASSUME_NONNULL_BEGIN

@interface TweetDetailsViewController : UIViewController
@property (weak, nonatomic) Tweet *tweet;

@end

NS_ASSUME_NONNULL_END
