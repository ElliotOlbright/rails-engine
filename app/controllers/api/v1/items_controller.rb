class Api::V1::ItemsController < ApplicationController 
  def index 
    render Json: Item.all
  end 
end 