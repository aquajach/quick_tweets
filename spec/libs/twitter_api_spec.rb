require_relative '../../lib/twitter_api'
require 'webmock/rspec'
require 'rails_helper'

describe TwitterAPI do
  describe 'refresh_bearer_token' do
    it 'gets the new bearer token' do
      stub_request(:post, 'https://api.twitter.com/oauth2/token').to_return(
          body: "{\"token_type\":\"bearer\",\"access_token\":\"AAA\"}"
      )
      expect(described_class.refresh_bearer_token).to eql('AAA')
      expect(ENV['TWITTER_BEARER_TOKEN']).to eql('AAA')
    end
  end

  describe 'timeline' do
    context 'when bearer token is available' do
      it 'gets the recent tweets' do
        expect(described_class).not_to receive(:refresh_bearer_token)
        ENV['TWITTER_BEARER_TOKEN'] = 'xyz'
        stub_request(:get, 'https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name=abc').to_return(
            body: File.read(File.dirname(__FILE__) + '/../support/tweets_in_timeline.json')
        )
        expect(described_class.timeline('abc').count).to eql 2
      end
    end

    context 'when bearer token does not exist in env' do
      it 'gets the recent tweets' do
        expect(described_class).to receive(:refresh_bearer_token)
        ENV['TWITTER_BEARER_TOKEN'] = nil
        stub_request(:get, 'https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name=abc').to_return(
            body: File.read(File.dirname(__FILE__) + '/../support/tweets_in_timeline.json')
        )
        expect(described_class.timeline('abc').count).to eql 2
      end
    end
  end
end