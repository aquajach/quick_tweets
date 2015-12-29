class Tweet
  attr_reader :text

  def initialize(tweet_json)
    @text = tweet_json['text']
  end

  def self.in_timeline(screen_name)
    TwitterAPI.timeline(screen_name)
  end

end