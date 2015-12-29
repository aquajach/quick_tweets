require_relative '../../app/models/tweet'
require 'json'

describe Tweet do
  describe '#new' do
    it 'creates tweet from the json' do
      json = JSON.parse(File.read(File.dirname(__FILE__) + '/../support/single_tweet.json'))
      tweet = Tweet.new(json)
      expect(tweet.text).to eql('@TwitterEng Introducing the Twitter Certified Products Program @TwitterOSS: https://t.co/MjJ8xAnT')
      expect(tweet.user_mentions).to eql(['TwitterEng', 'TwitterOSS'])
      expect(tweet.user_name).to eql('Twitter API')
      expect(tweet.profile_thumbnail_url).to eql('http://a0.twimg.com/profile_images/2284174872/7df3h38zabcvjylnyfe3_normal.png')
      expect(tweet.created_at).to eql(Time.utc(2012, 8, 29, 17, 12, 58))
      expect(tweet.user_screen_name).to eql('twitterapi')
    end
  end
end
