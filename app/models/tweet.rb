class Tweet
  attr_reader :text, :user_mentions

  def initialize(tweet_json)
    @text = tweet_json['text']
    @user_mentions = tweet_json['entities']['user_mentions'].map{|mention| mention['screen_name']}
  end

  def self.in_timeline(screen_name)
    Rails.cache.fetch("timeline/#{screen_name}", expires_in: 5.minutes) do
      TwitterAPI.timeline(screen_name)
    end
  end
end
