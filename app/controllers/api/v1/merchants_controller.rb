class Api::V1::MerchantsController < ApplicationController 
  def index 
    render Json: Merchant.all
  end 
end 