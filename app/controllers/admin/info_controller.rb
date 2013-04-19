class Admin::InfoController < ApplicationController
  def index
    @infoList = Info.order("id DESC")
  end

  def new
    info = Info.new
    assignParams info, params
    info.save
    redirect_to "/admin/info/index"
  end

  def destroy
    info = Info.find(params[:id])
    info.destroy
    redirect_to "/admin/info/index"
  end

  def edit
    @info = Info.find(params[:id])
    unless params[:title].nil?
      assignParams @info, params
      @info.save
    end
  end
  
  private 
  
  def assignParams (info, params)
    info.title = params[:title]
    info.image = params[:image]
    info.url = params[:url]
    info.description = params[:description]
    info.deleted = 0
    info.priority = 0
    info.app_store = (params[:app_store].nil?) ? 0 : 1
  end
end
