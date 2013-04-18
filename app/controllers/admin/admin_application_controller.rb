class Admin::AdminApplicationController < ApplicationController
  http_basic_authenticate_with :name => "fanap", :password => "fanap1234" 
end
