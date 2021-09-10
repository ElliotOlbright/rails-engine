class Api::V1::Merchants::ItemsSoldController < ApplicationController

  def index
    if params[:quantity].present? && params[:quantity].to_i > 0
      merchants = Merchant.top_sellers(params[:quantity])
      render json: MerchantItemSerializer.new(merchants)
    else
      render json: {error: {}}, status: 400
    end
  end

end