require 'rails_helper'

describe "Item API" do
  it "sends a list of items" do
    create_list(:item, 3)

    get '/api/v1/items'

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)

    expect(items.count).to eq(3)

    items.each do |i|
      expect(i).to have_key(:id)
      expect(i[:id]).to be_an(Integer)

      expect(i).to have_key(:description)
      expect(i[:description]).to be_a(String)

      expect(i).to have_key(:unit_price)
      expect(i[:unit_price]).to be_an(Float)
    end 
  end

  it "can get one item by its id" do
    id = create(:item).id
  
    get "/api/v1/items/#{id}"
  
    item = JSON.parse(response.body, symbolize_names: true)
  
    expect(response).to be_successful
  
    expect(item).to have_key(:id)
    expect(item[:id]).to be_an(Integer)
  
    expect(item).to have_key(:name)
    expect(item[:name]).to be_a(String)
  
    expect(item).to have_key(:description)
    expect(item[:description]).to be_a(String)
  
    expect(item).to have_key(:unit_price)
    expect(item[:unit_price]).to be_a(Float)
  end

  it "can create a new item" do
    merchant = create(:merchant)

    item_params = ({
                    name: 'Guitar',
                    description: 'It goes twangy twangy',
                    unit_price: 150.99,
                    merchant_id: merchant.id
                  })

    headers = {"CONTENT_TYPE" => "application/json"}
  
    post "/api/v1/items", headers: headers, params: JSON.generate(item: item_params)
    created_item = Item.last

    expect(response).to be_successful
    expect(created_item.name).to eq(item_params[:name])
    expect(created_item.description).to eq(item_params[:description])
    expect(created_item.unit_price).to eq(item_params[:unit_price])
  end

  it "can update an existing item" do
    merchant = create(:merchant)
    id = create(:item).id
    previous_name = Item.last.name
    item_params = ({
                    name: 'GuitarX',
                    description: 'It goes twangy twangy twooop',
                    unit_price: 150.99,
                    merchant_id: merchant.id
                  })

    headers = {"CONTENT_TYPE" => "application/json"}
  

    patch "/api/v1/items/#{id}", headers: headers, params: JSON.generate({item: item_params})
    item = Item.find_by(id: id)
  
    expect(response).to be_successful
    expect(item.name).to_not eq(previous_name)
    expect(item.name).to eq("GuitarX")
  end

  it "can destroy an item" do
    merchant = create(:merchant)
    item = create(:item)
  
    expect(Item.count).to eq(1)
  
    delete "/api/v1/items/#{item.id}"
  
    expect(response).to be_successful
    expect(Item.count).to eq(0)
    expect{Item.find(item.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end
end