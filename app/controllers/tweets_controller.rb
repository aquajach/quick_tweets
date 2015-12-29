class TweetsController < ApplicationController
  def index
    if params[:screen_name].present?
      @tweets = Tweet.in_timeline(params[:screen_name])
    end
  end
end
