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

  it "can get one book by its id" do
    id = create(:merchant).id
  
    get "/api/v1/merchants/#{id}"
  
    merchant = JSON.parse(response.body, symbolize_names: true)
  
    expect(response).to be_successful
  
    expect(merchant).to have_key(:id)
    expect(merchant[:id]).to eq(id)
  
    expect(merchant).to have_key(:name)
    expect(merchant[:name]).to be_a(String)
  end
end 