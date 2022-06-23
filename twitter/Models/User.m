//
//  User.m
//  twitter
//
//  Created by Iris Fu on 6/20/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "User.h"

@implementation User

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];

    if (self) {
        self.name = dictionary[@"name"];
        self.screenName = dictionary[@"screen_name"];
        self.profilePicture = dictionary[@"profile_image_url_https"];
        self.headerPicture = dictionary[@"profile_banner_url"];
        self.bio = dictionary[@"description"];
        self.followingCount = [NSString stringWithFormat:@"%@", dictionary[@"friends_count"]];
        self.followerCount = [NSString stringWithFormat:@"%@", dictionary[@"followers_count"]];
        self.tweetCount = [NSString stringWithFormat:@"%@", dictionary[@"statuses_count"]];
    }
    return self;
}

@end
