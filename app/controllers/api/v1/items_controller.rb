class Api::V1::ItemsController < ApplicationController 
  
  def index 
    items = Item.paginate(page: params[:page], per_page: 20)
    render json: ItemSerializer.new(items)
  end 

  def show 
    item = Item.find(params[:id])
    render json: ItemSerializer.new(item)
  end

  def create
    render json: Item.create(item_params)
  end

  def update 
    render json: Item.update(params[:id], item_params)
  end

  def destroy 
    render json: Item.destroy(params[:id])
  end 

  private 

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end
end 