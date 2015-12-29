module ApplicationHelper
  def text_with_mentions(text, mentions)
    attributed_text = text
    mentions.each do |mention|
      attributed_text = attributed_text.gsub("@#{mention}", "<a href=\"?screen_name=#{mention}\">@#{mention}</a>")
    end
    attributed_text
  end
end
