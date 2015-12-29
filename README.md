## README

**a. App Design / Choices Made**

* This is a single rails application without database or activerecord

* The purpose of the app is to provide a quick way to browse the recent tweets of any twitter user. Therefore, it doesn't necesssarily integrate with any comprehensive twitter api lib or gem

* The app doesn't require users to log in for access token. Instead, it uses Twitter's Application-only authentication. There are two endpoints are involved:

  1.  /oauth2/token, to get the bearer token, check [the detail](https://github.com/aquajach/quick_tweets/blob/master/lib/twitter_api.rb#L6)

  2. /statuses/user_timeline, to get the recents tweets in users timeline, check [the detail](https://github.com/aquajach/quick_tweets/blob/master/lib/twitter_api.rb#L35)

  Note: 1) is skipped if bearer token (that never expires) has been saved as a environment variable
  
* The timeline of a specific user is cached for 5 minutes in the app
  
* Images and other rich format in tweets are not supported yet, but @mention tag works  

**b. Local environment setup**

1). ```git clone https://github.com/aquajach/quick_tweets```

2). Install ruby 2.3 with rvm or rbenv

3. ```bundle install```
4. ```rails server```

**c. Basic heroku setup**

1. Create heroku application: ```heroku create *new_app*```
2. Set heroku config for Twitter application:
```heroku config:set TWITTER_CONSUMER_KEY=*your_twitter_consumer_key*```
```heroku config:set TWITTER_CONSUMER_SECRET=*your_twitter_consumer_secret*```
3. ```git push heroku```

**d. Test/spec setup**

1. Add rspec-rails to Gemfile and ```bundle install```
2. Generate templates: ```rails generate rspec:install```
3. Run the spec suite by ```bundle exec rspec```


**e. Heroku link**
The demo has been deployed to: [http://quick-tweets.herokuapp.com/](http://quick-tweets.herokuapp.com/)
