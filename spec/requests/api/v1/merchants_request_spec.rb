require 'rails_helper'

describe "Merchants API" do 
  it "sends a list of merchants" do 
    create_list(:merchant, 10)

    get '/api/v1/merchants'

    expect(response).to be_successful 


    merchants = JSON.parse(response.body, symbolize_names: true)



    merchants.each do |m|
      expect(m).to have_key(:id)
      expect(m[:id]).to be_an(Integer)

      expect(m).to have_key(:name)
      expect(m[:name]).to be_a(String)
    end
  end

  it "can get one merchant by its id" do
    id = create(:merchant).id
  
    get "/api/v1/merchants/#{id}"
  
    merchant = JSON.parse(response.body, symbolize_names: true)
  
    expect(response).to be_successful
  
    expect(merchant).to have_key(:id)
    expect(merchant[:id]).to eq(id)
  
    expect(merchant).to have_key(:name)
    expect(merchant[:name]).to be_a(String)
  end

  it "can get a merchants items" do 
    merchant = create(:merchant)

    create_list(:item, 10, merchant_id: merchant.id)
    get "/api/v1/merchants/#{merchant.id}/items"

    items = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful

    items[:data].each do |item|

      expect(item).to have_key(:id)
      expect(item[:id]).to be_a(String)
    
      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_a(String)
    
      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:description]).to be_a(String)
    
      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to be_a(Float)
    end
  end
end 