class Admin::ItemController < ApplicationController
  
  def destroy
    item = Item.find(params[:id])
    item.deleted = 1
    item.save
    
    redirect_to "/admin/rss/index"
  end
  
  def update
    rssList = Rss.order("id DESC")
    @rssList = rssList
    require "rss"
    require "rss/1.0"
    require "rss/2.0"
    require 'rss/dublincore'
    require 'rss/content'
    require 'date'
    startTime = Time.now.gmtime.to_i
    puts "start items"
    queue = Queue.new()
    
    rssList.each do |rss|
      queue.push(rss)
    end
                
    lock = Monitor.new
    threadNum = 5
    puts queue.size()
    threads = []
    for i in 0..threadNum do
      t = Thread.start(queue, t){|queue, t|
        while(queue.size() > 0)
          rss = nil
          lock.synchronize do
            rss = queue.pop()
          end
          url = rss[:url]
          if url == "" || url ==nil 
            continue
          end
            rssId = rss[:id]
          # begin
            rss_source = open(url).read
            rss = RSS::Parser.parse(rss_source, false)
            saveRssItem(rss, rssId)
          # rescue => exc
#             
          # end
        end
      }
      threads.push(t)
    end
    threads.each{|t|
      t.join
    }
    
    endTime = Time.now.gmtime.to_i
    progress = endTime - startTime
    puts "end:" + progress.to_s
    redirect_to "/admin/rss/index"
  end
  
# private ==========================================
  private
  
  def saveRssItem(rss, rssId)
    
    itemList = nil
    if rss.items
      itemList = rss.items
    else
      
    end
    
    itemList.each do |item|
      saveItem(item, rssId)
    end
    
  end
  
  def saveItem(item, rssId)
    date = nil
    
    if item.instance_of?(RSS::Atom::Feed::Entry)
      # TODO atomはよくわからん
      date = DateTime.parse(item.updated.to_s);
    elsif item.dc_date
      date = DateTime.parse(item.dc_date.to_s);
    elsif item.pubDate != nil
      date = DateTime.parse(item.pubDate.to_s);      
    end
    
    if date == nil 
      return 
    end
    pubdate = date.to_time.to_i
    
    unless item.instance_of?(RSS::Atom::Feed::Entry)
      imageList = item.content_encoded.to_s.scan(/img.+src=[\"|\']?([\-_\.\!\~\*\'\(\)a-zA-Z0-9\;\/\?\:@&=\$\,\%\#]+\.(jpg|jpeg|png|gif|bmp))/i)
      unless imageList[0]
        imageList = item.description.to_s.scan(/img.+src=[\"|\']?([\-_\.\!\~\*\'\(\)a-zA-Z0-9\;\/\?\:@&=\$\,\%\#]+\.(jpg|jpeg|png|gif|bmp))/i)
      end
    end
    
    model = Item.new
    if(!item.instance_of?(RSS::Atom::Feed::Entry) and imageList[0])
      model.image_url = imageList[0][0]
    else
      model.image_url = nil
    end
    model.link = item.link.to_s.gsub(/<\/?[^>]*>/, "")
    model.pubdate = pubdate
    model.rss_id = rssId
    model.title = item.title.to_s.gsub(/<\/?[^>]*>/, "")
    model.tweet_count = 0
    
    if model.title.include?("PR:")
      return
    end
    
    if model.link.include?(":80")
      return
    end
    
    if model.link == nil
      return
    end
    
    if existsItem(model)
      return
    end
    
    model.save()
  end
  
  # link unique
  def existsItem(model)
    itemList = Item.where(["link = ? AND rss_id = ?", model.link, model.rss_id]);
    return itemList.count != 0
  end
end
