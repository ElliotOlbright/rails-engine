require 'rails_helper'

describe "Merchants API" do 
  it "sends a list of merchants" do 
    create_list(:merchant, 10)

    get '/api/v1/merchants'

    expect(response).to be_successful 


    merchants = JSON.parse(response.body, symbolize_names: true)



    merchants[:data].each do |m|
      expect(m).to have_key(:id)
      expect(m[:id]).to be_a(String)

      expect(m[:attributes]).to have_key(:name)
      expect(m[:attributes][:name]).to be_a(String)
    end
  end

  it "can get one merchant by its id" do
    id = create(:merchant).id
  
    get "/api/v1/merchants/#{id}"
  
    merchant = JSON.parse(response.body, symbolize_names: true)
  
    expect(response).to be_successful
  
    expect(merchant[:data]).to have_key(:id)
    expect(merchant[:data][:id]).to be_a(String)
  
    expect(merchant[:data][:attributes]).to have_key(:name)
    expect(merchant[:data][:attributes][:name]).to be_a(String)
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

  it 'can find one merchant based on search criteria' do 
    merchant1 = create(:merchant, name: "222")
    merchant2 = create(:merchant)
    merchant3 = create(:merchant)

    get "/api/v1/merchants/find?name=222"

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful

    expect(merchant[:data]).to have_key(:id)
    expect(merchant[:data][:id]).to be_a(String)

    expect(merchant[:data][:attributes]).to have_key(:name)
    expect(merchant[:data][:attributes][:name]).to be_a(String)
  end 
end 