class Api::V1::Merchants::SearchController < ApplicationController 
  def show 
    merchant = Search.find_by_name(Merchant, params[:name].first) if params[:name]
    if merchant.present?
      render json: MerchantSerializer.new(merchant)
    else
      render json: { "data": {} }
    end 
  end 
end