class TweetsController < ApplicationController
  def index
    if params[:screen_name]
      @tweets = Tweet.in_timeline(params[:screen_name])
    end
  end
end