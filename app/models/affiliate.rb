class Affiliate < ActiveRecord::Base
  attr_accessible :deleted, :description, :image, :link, :name, :priority
end
