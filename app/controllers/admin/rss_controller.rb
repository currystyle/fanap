class Admin::RssController < Admin::AdminApplicationController
  def index
    @rssList = Rss.where("deleted == 0").order("id DESC")
    @itemList = Item.where("deleted == 0").order("pubdate DESC")
  end

  def new
    rss = Rss.new(:name=>params[:name], :url=>params[:url], :deleted=>0)
    rss.save
    redirect_to "/admin/rss/index"
  end

  def edit
    @rss = Rss.find(params[:id])
    unless params[:name].nil?
      @rss.name = params[:name]
      @rss.url = params[:url]
      @rss.save
    end
  end

  def destroy
    rssId = params[:id];
    
    # items削除
    nowTime = Time.now.to_s(:db)
    args = ["UPDATE items SET deleted = 1, updated_at = ? WHERE rss_id = ?", nowTime, rssId]
    sql = ActiveRecord::Base.send(:sanitize_sql_array, args)
    Item.connection.execute(sql)
    
    # rss削除
    rss = Rss.find(rssId)
    rss.deleted = 1;
    rss.save
    
    redirect_to "/admin/rss/index"
  end
end
