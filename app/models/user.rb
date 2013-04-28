class User < ActiveRecord::Base
  attr_accessible :age, :device_token, :height, :message, :name, :url, :work
end
