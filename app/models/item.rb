class Item < ActiveRecord::Base
  attr_accessible :deleted, :image_url, :link, :pubdate, :rss_id, :title, :tweet_count
end
