class Api::UserController < ApplicationController
    SALT = "8fkQjL5cYBj6smaSXrUjGDXsJViGEGgixYF9bHc6mAsNGyH8Qx"
    
  def new
        if params[:device_token].nil?
            abort("invalide request")
        end
        device_token = params[:device_token]
        if User.exists?(:device_token => device_token) # すでに登録済み
            render :json => 2
            return
        end
        user = User.new()
        user.device_token = params[:device_token]
        if user.save()
            render :json => 0
        else
            render :json => 1
        end
  end

  def edit
      
  end
end
