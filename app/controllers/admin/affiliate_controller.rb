class Admin::AffiliateController < ApplicationController
  def index
    @affiList = Affiliate.order("id DESC")
  end

  def new
    affiliate = Affiliate.new
    affiliate.name = params[:name]
    affiliate.image = params[:image]
    affiliate.link = params[:link]
    affiliate.description = params[:description]
    affiliate.save
    redirect_to "/admin/affiliate/index"
  end

  def edit
    @affiliate = Affiliate.find(params[:id])
    unless params[:name].nil?
      @affiliate.name = params[:name]
      @affiliate.image = params[:image]
      @affiliate.link = params[:link]
      @affiliate.description = params[:description]
      @affiliate.save
    end
  end

  def destroy
    affiliate = Affiliate.find(params[:id])
    affiliate.destroy
    redirect_to "/admin/affiliate/index"
  end
end
