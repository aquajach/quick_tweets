require 'net/https'
require 'base64'
require 'uri'

module TwitterAPI
  def self.refresh_bearer_token
    consumer_token = "#{::Rails.application.secrets.twitter_consumer_key}:#{::Rails.application.secrets.twitter_consumer_secret}"
    encoded_bearer_token = Base64.strict_encode64(consumer_token)

    url = URI.parse('https://api.twitter.com/oauth2/token')

    https = Net::HTTP.new(url.host, 443)
    https.use_ssl = true

    https.start do
      header = {}
      header['Authorization'] = "Basic #{encoded_bearer_token}"
      header['Content-Type'] = 'application/x-www-form-urlencoded;charset=UTF-8'

      req = Net::HTTP::Post.new(url.path, header)
      req.body = 'grant_type=client_credentials'

      resp = https.request(req)

      begin
        if JSON.parse(resp.body)['access_token'].present?
          ENV['TWITTER_BEARER_TOKEN'] = JSON.parse(resp.body)['access_token']
        end
      rescue
        ::Rails.logger.error "Fetching bearer token resulted in error: #{resp.body}"
      end
    end
  end

  def self.timeline(screen_name)
    url = URI.parse("https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name=#{screen_name}&count=25")
    https = Net::HTTP.new(url.host, 443)
    https.use_ssl = true

    bearer_token = ENV['TWITTER_BEARER_TOKEN'] || self.refresh_bearer_token

    https.start do
      header = {}
      header['Authorization'] = "Bearer #{bearer_token}"

      req = Net::HTTP::Get.new(url, header)
      resp = https.request(req)

      begin
        tweets = JSON.parse(resp.body)

        if tweets.present?
          return tweets.map{|raw_tweet| Tweet.new(raw_tweet)}
        end
      rescue
        ::Rails.logger.error "Fetching timeline for #{screen_name} resulted in error: #{resp.body}"
        return []
      end
    end
  end
end
