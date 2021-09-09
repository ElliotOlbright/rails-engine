class Api::V1::ItemsController < ApplicationController 
  
  def index 
    items = Item.paginate(page: params[:page] || 1, per_page: params[:per_page] || 20) 
    render json: ItemSerializer.new(items)
  end 

  def show 
    item = Item.find(params[:id])
    render json: ItemSerializer.new(item)
  end

  def create
    item = Item.create!(item_params)
    render json: ItemSerializer.new(item), status: 201
  end

  def update 
    item = Item.find_by!(id: params[:id])
    item.update!(item_params)
		render json: ItemSerializer.new(item)
  end

  def destroy 
    render json: Item.destroy(params[:id])
  end 

  private 

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end
end 