class Admin::RecommendController < ApplicationController
  def index
    @recommendList = Recommend.where("deleted = 0").order("id DESC")
  end

  def new
    recommend = Recommend.new
    recommend.name = params[:name]
    recommend.image = params[:image]
    recommend.link = params[:link]
    recommend.description = params[:description]
    recommend.deleted = 0;
    recommend.save
    redirect_to "/admin/recommend/index"
  end

  def edit
    @recommend = Recommend.find(params[:id])
    unless params[:name].nil?
      @recommend.name = params[:name]
      @recommend.image = params[:image]
      @recommend.link = params[:link]
      @recommend.description = params[:description]
      @recommend.save
    end
  end

  def destroy
    recommend = Recommend.find(params[:id])
    recommend.de
    redirect_to "/admin/recommend/index"
  end
end
