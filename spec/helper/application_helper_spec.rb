require_relative '../../app/helpers/application_helper'
include ApplicationHelper

describe ApplicationHelper do
  describe '#text_with_mentions' do
    it 'replaces the mentions with a link to the user timeline' do
      expect(text_with_mentions('we@tweet all the @time', ['tweet', 'time'])).to eql ('we<a href="?screen_name=tweet">@tweet</a> all the <a href="?screen_name=time">@time</a>')
    end
  end
end
