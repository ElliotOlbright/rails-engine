require 'rails_helper'

describe "Item API" do
  it "sends a list of items" do
    create_list(:item, 1)

    get '/api/v1/items'

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)

    expect(items.count).to eq(1)

    items[:data].each do |i|
      expect(i).to have_key(:id)
      expect(i[:id]).to be_an(String)

      expect(i[:attributes]).to have_key(:description)
      expect(i[:attributes][:description]).to be_a(String)

      expect(i[:attributes]).to have_key(:unit_price)
      expect(i[:attributes][:unit_price]).to be_an(Float)
    end 
  end

  it "can get one item by its id" do
    id = create(:item).id
  
    get "/api/v1/items/#{id}"
  
    item = JSON.parse(response.body, symbolize_names: true)
  
    expect(response).to be_successful

    expect(item[:data]).to have_key(:id)
    expect(item[:data][:id]).to be_a(String)
  
    expect(item[:data][:attributes]).to have_key(:name)
    expect(item[:data][:attributes][:name]).to be_a(String)
  
    expect(item[:data][:attributes]).to have_key(:description)
    expect(item[:data][:attributes][:description]).to be_a(String)
  
    expect(item[:data][:attributes]).to have_key(:unit_price)
    expect(item[:data][:attributes][:unit_price]).to be_a(Float)
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

  it 'can return an items merchant' do
    merchant = create(:merchant) 
    create_list(:item, 10, merchant_id: merchant.id)

    expect(Item.count).to eq(10)

    get "/api/v1/items/#{Item.first.id}/merchant"

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful

    expect(merchant[:data]).to have_key(:id)
    expect(merchant[:data][:id]).to be_a(String)
  
    expect(merchant[:data][:attributes]).to have_key(:name)
    expect(merchant[:data][:attributes][:name]).to be_a(String)
  end

  it 'can return all items with a partial name' do 
    merchant = create(:merchant)
    item1 = create(:item, name: "222", description: "1234", unit_price: 10.99, merchant_id: merchant.id)
    item2 = create(:item, name: "223", description: "1234", unit_price: 10.99, merchant_id: merchant.id)
    item3 = create(:item, name: "224", description: "1234", unit_price: 10.99, merchant_id: merchant.id)
    item4 = create(:item, name: "225", description: "1234", unit_price: 10.99, merchant_id: merchant.id)
    item5 = create(:item, name: "226", description: "1234", unit_price: 10.99, merchant_id: merchant.id)
    item6 = create(:item, name: "337", description: "1234", unit_price: 10.99, merchant_id: merchant.id)
    item7 = create(:item, name: "357", description: "1234", unit_price: 10.99, merchant_id: merchant.id)
    item8 = create(:item, name: "6547", description: "1234", unit_price: 10.99, merchant_id: merchant.id)

    get "/api/v1/items/find_all?name=2"

    items = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful

    expect(items[:data].count).to eq(5)

    items[:data].each do |i|
      expect(i).to have_key(:id)
      expect(i[:id]).to be_an(String)

      expect(i[:attributes]).to have_key(:description)
      expect(i[:attributes][:description]).to be_a(String)

      expect(i[:attributes]).to have_key(:unit_price)
      expect(i[:attributes][:unit_price]).to be_an(Float)
    end 
  end
end