class Rss < ActiveRecord::Base
  attr_accessible :deleted, :name, :url
end
