class Admin::RssController < Admin::AdminApplicationController
  def index
    @rssList = Rss.order("id DESC")
    
  end

  def new
    rss = Rss.new(:name=>params[:name], :url=>params[:url])
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
    rss = Rss.find(params[:id])
    rss.destroy
    redirect_to "/admin/rss/index"
  end
end
