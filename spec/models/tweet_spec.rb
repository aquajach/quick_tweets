require_relative '../../app/models/tweet'
require 'json'

describe Tweet do
  describe '#new' do
    it 'creates tweet from the json' do
      json = JSON.parse(File.read(File.dirname(__FILE__) + '/../support/single_tweet.json'))
      tweet = Tweet.new(json)
      expect(tweet.text).to eql('Introducing the Twitter Certified Products Program: https://t.co/MjJ8xAnT')
    end
  end
end