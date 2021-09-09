class Api::V1::Items::SearchController < ApplicationController 
  def show 
    items = Search.find_by_name(Item, params[:name]) if params[:name] && params[:name].empty? == false
    if items.present? 
      render json: ItemSerializer.new(items)
    else
      render json: { "data": [] }, status: 400
    end 
  end 
end