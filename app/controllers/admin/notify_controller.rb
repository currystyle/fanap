# encoding: utf-8
class Admin::NotifyController < ApplicationController
  def index
  end

  def edit
  end

  def test
      @userList = User.order("id DESC")
      user = @userList[0]
      
      alert = "「春のカジュアルコーデ」に新しいコメントがあります"
      badge = 10
      
      push_row user[:device_token], alert, badge
  end

  def push
      
  end

  def delete
  end
  
  #private ===========================
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
    
    payload = {"aps" => {"alert" => alert, "badge" => badge, "sound" => 'default'}}
    json = payload.to_json()
    token =  [token.delete(' ')].pack('H*') 
    apnsMessage = "\0\0 #{token}\0#{json.length.chr}#{json}"
    
    ssl.write(apnsMessage)
    ssl.close
    @soc.close
  end

end
