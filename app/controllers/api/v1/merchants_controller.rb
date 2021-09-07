class Api::V1::MerchantsController < ApplicationController 

  def index 
    merchants =  Merchant.paginate(page: params[:page], per_page: 20)
    render json: MerchantSerializer.new(merchants)
  end 

  def show 
    merchant = Merchant.find(params[:id])
    render json: MerchantSerializer.new(merchant)
  end
end 
