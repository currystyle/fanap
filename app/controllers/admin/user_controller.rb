class Admin::UserController < ApplicationController
  def index
    @userList = User.order("id DESC")
  end

  def new
    
  end

  def edit
    @user = User.find(params[:id])
    unless params[:name].nil?
      @user.name = params[:name]
      @user.url = params[:url]
      @user.message = params[:message]
      @user.height = params[:height]
      @user.work = params[:work]
      @user.age = params[:age]
      
      @user.save()
    end
  end

  def destroy
    
  end
  
  def push
    @user = User.find(params[:id])
    unless params[:alert].nil?
      push_row @user[:device_token], params[:alert], params[:badge]
      redirect_to "/admin/user/push/" + @user.id.to_s                  
    end
  end
  
  # private =================================
  
  private 
  
  def push_row(token, alert, badge)
    certFilePath = Rails.root.join('app', 'assets', 'push', 'apns-dev.pem')
    keyFilePath = Rails.root.join('app', 'assets', 'push', 'apns-dev-key-noenc.pem')
 
    @soc = TCPSocket.new('gateway.sandbox.push.apple.com', 2195)
    @ctx = OpenSSL::SSL::SSLContext.new('SSLv3')
    @ctx.cert = OpenSSL::X509::Certificate.new(File.read(certFilePath))
    @ctx.key = OpenSSL::PKey::RSA.new(File.read(keyFilePath))
  
    ssl = OpenSSL::SSL::SSLSocket.new(@soc, @ctx)
    ssl.connect
    
    payload = {"aps" => {"alert" => alert, "badge" => badge.to_i, "sound" => 'default'}}
    json = payload.to_json()
    token =  [token.delete(' ')].pack('H*') 
    apnsMessage = "\0\0 #{token}\0#{json.length.chr}#{json}"
    
    ssl.write(apnsMessage)
    ssl.close
    @soc.close
  end
  
end
