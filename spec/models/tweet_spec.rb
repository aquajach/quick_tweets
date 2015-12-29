require_relative '../../app/models/tweet'
require 'json'

describe Tweet do
  describe '#new' do
    it 'creates tweet from the json' do
      json = JSON.parse(File.read(File.dirname(__FILE__) + '/../support/single_tweet.json'))
      tweet = Tweet.new(json)
      expect(tweet.text).to eql('@TwitterEng Introducing the Twitter Certified Products Program @TwitterOSS: https://t.co/MjJ8xAnT')
      expect(tweet.user_mentions).to eql(['TwitterEng', 'TwitterOSS'])
    end
  end
end
