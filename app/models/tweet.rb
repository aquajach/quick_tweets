class Tweet
  attr_reader :text, :user_mentions, :profile_thumbnail_url, :user_name, :created_at, :user_screen_name

  def initialize(tweet_json)
    @text = tweet_json['text']
    @user_mentions = tweet_json['entities']['user_mentions'].map{|mention| mention['screen_name']}
    @user_name = tweet_json['user']['name']
    @profile_thumbnail_url = tweet_json['user']['profile_image_url']
    @created_at = Time.parse(tweet_json['created_at'])
    @user_screen_name = tweet_json['user']['screen_name']
  end

  def self.in_timeline(screen_name)
    Rails.cache.fetch("timeline/#{screen_name}", expires_in: 5.minutes) do
      TwitterAPI.timeline(screen_name)
    end
  end
end
