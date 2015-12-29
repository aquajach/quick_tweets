class Tweet
  attr_reader :text

  def initialize(tweet_json)
    @text = tweet_json['text']
  end

  def self.in_timeline(screen_name)
    Rails.cache.fetch("timeline/#{screen_name}", expires_in: 5.minutes) do
      TwitterAPI.timeline(screen_name)
    end
  end
end
