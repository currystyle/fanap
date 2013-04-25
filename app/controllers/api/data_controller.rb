class Api::DataController < ApplicationController
  def update
    lastupdated = params[:lastupdated];
    lastUpdateDate = Time.at(lastupdated.to_i).to_s(:db)
    
    createdRssList = Rss.where('created_at > ? AND deleted = 0', lastUpdateDate)
    updatedRssList = Rss.where('updated_at > ? AND deleted = 0 AND created_at != updated_at', lastUpdateDate)
    deletedRssList = Rss.where('updated_at > ? AND deleted = 1', lastUpdateDate)
    
    createdItemList = Item.where('created_at > ? AND deleted = 0', lastUpdateDate)
    updatedItemList = Item.where('updated_at > ? AND deleted = 0 AND created_at != updated_at', lastUpdateDate)
    deletedItemList = Item.where('updated_at > ? AND deleted = 1', lastUpdateDate)
    
    createdRecommendList = Recommend.where('created_at > ? AND deleted = 0', lastUpdateDate)
    updatedRecommendList = Recommend.where('updated_at > ? AND deleted = 0 AND created_at != updated_at', lastUpdateDate)
    deletedRecommendList = Recommend.where('updated_at > ? AND deleted = 1', lastUpdateDate)
    
    createdAffiliateList = Affiliate.where('created_at > ? AND deleted = 0', lastUpdateDate)
    updatedAffiliateList = Affiliate.where('updated_at > ? AND deleted = 0 AND created_at != updated_at', lastUpdateDate)
    deletedAffiliateList = Affiliate.where('updated_at > ? AND deleted = 1', lastUpdateDate)
    
    createdInfoList = Info.where('created_at > ? AND deleted = 0', lastUpdateDate)
    updatedInfoList = Info.where('updated_at > ? AND deleted = 0 AND created_at != updated_at', lastUpdateDate)
    deletedInfoList = Info.where('updated_at > ? AND deleted = 1', lastUpdateDate)
    
    data = {
      "rss"=>{
        "created" => createdRssList, 
        "updated" => updatedRssList, 
        "deleted" => deletedRssList
      },
      "item" =>{
        "created" => createdItemList,
        "updated" => updatedItemList,
        "deleted" => deletedItemList
      },
      "recommend" =>{
        "created" => createdRecommendList,
        "updated" => updatedRecommendList,
        "deleted" => deletedRecommendList
      },
      "affiliate" =>{
        "created" => createdAffiliateList,
        "updated" => updatedAffiliateList,
        "deleted" => deletedAffiliateList
      },
      "info" =>{
        "created" => createdInfoList,
        "updated" => updatedInfoList,
        "deleted" => deletedInfoList
      },
      "timestamp" => Time.now.gmtime.to_i,
      "lastUpdated" => lastUpdateDate
    }
    
    render :json => data.to_json
    
  end
end
