# Project 2 - *Twitter*

**Twitter** is a basic twitter app to read and compose tweets the [Twitter API](https://apps.twitter.com/).

Time spent: **20** hours spent in total

## User Stories

The following **core** features are completed:

**A user should**

- [x] See an app icon in the home screen and a styled launch screen
- [x] Be able to log in using their Twitter account
- [x] See at latest the latest 20 tweets for a Twitter account in a Table View
- [x] Be able to refresh data by pulling down on the Table View
- [x] Be able to like and retweet from their Timeline view
- [x] Only be able to access content if logged in
- [x] Each tweet should display user profile picture, username, screen name, tweet text, timestamp, as well as buttons and labels for favorite, reply, and retweet counts.
- [x] Compose and post a tweet from a Compose Tweet view, launched from a Compose button on the Nav bar.
- [x] See Tweet details in a Details view
- [x] App should render consistently all views and subviews in recent iPhone models and all orientations

The following **stretch** features are implemented:

**A user could**

- [x] Be able to **unlike** or **un-retweet** by tapping a liked or retweeted Tweet button, respectively. (Doing so will decrement the count for each)
- [ ] Click on links that appear in Tweets
- [ ] See embedded media in Tweets that contain images or videos
- [x] Reply to any Tweet (**2 points**)
  - Replies should be prefixed with the username
  - The `reply_id` should be set when posting the tweet
- [x] See a character count when composing a Tweet (as well as a warning) (280 characters) (**1 point**)
- [x] Load more tweets once they reach the bottom of the feed using infinite loading similar to the actual Twitter client
- [ ] Click on a Profile image to reveal another user's profile page, including:
  - Header view: picture and tagline
  - Basic stats: #tweets, #following, #followers
- [ ] Switch between **timeline**, **mentions**, or **profile view** through a tab bar (**3 points**)
- [ ] Profile Page: pulling down the profile page should blur and resize the header image. (**4 points**)

The following **additional** features are implemented:

- [ ] List anything else that you can get done to improve the app functionality!

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. I'd like to learn about how we can have an infinite scroll on the home feed. I couldn't think of an elegant solution to continuously load older data as the user keeps scrolling down the home feed.
2. My reply button is quite janky right now. I'd like to discuss better ways to implement the reply feature.

## Video Walkthrough

Here's a walkthrough of implemented user stories:

Icon, launchscreen, login, feed
<img src='https://github.com/iristfu/Twitter/blob/main/twitter-demo-1.gif' title='Icon, launchscreen, login, feed' width='' alt='Icon, launchscreen, login, feed' />

Feed refresh, like/unlike, retweet/unretweet, logout
<img src='https://github.com/iristfu/Twitter/blob/main/twitter-demo-2.gif' title='Icon, launchscreen, login, feed' width='' alt='Icon, launchscreen, login, feed' />

Composing
<img src='https://github.com/iristfu/Twitter/blob/main/twitter-demo-6.gif' title='Icon, launchscreen, login, feed' width='' alt='Icon, launchscreen, login, feed' />

Replying
<img src='https://github.com/iristfu/Twitter/blob/main/twitter-demo-3.gif' title='Icon, launchscreen, login, feed' width='' alt='Icon, launchscreen, login, feed' />

Various orientations on different views
<img src='https://github.com/iristfu/Twitter/blob/main/twitter-demo-5.gif' title='Icon, launchscreen, login, feed' width='' alt='Icon, launchscreen, login, feed' />

Infinite scrolling
<img src='https://github.com/iristfu/Twitter/blob/main/twitter-demo-infinite-scroll.gif' title='Icon, launchscreen, login, feed' width='' alt='Icon, launchscreen, login, feed' />


GIF created with [Kap](https://getkap.co/).

## Notes

Working with the Twitter API was quite challenging, especially in the beginning when my API key and secret were not working. It was also a learning curve to read the documentation and apply the correct request endpoints accordingly. Furthermore, I think I got a lot better at using autolayout thorugh this project. I now feel more comfortable getting a UI to look exactly the way I want it to and be compatible with multiple devices and orientations. 

## Credits

List an 3rd party libraries, icons, graphics, or other assets you used in your app.

- [AFNetworking](https://github.com/AFNetworking/AFNetworking) - networking task library

## License

    Copyright [yyyy] [name of copyright owner]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
