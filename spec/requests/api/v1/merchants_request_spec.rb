require 'rails_helper'

describe "Merchants API" do 
  it "sends a list of merchants" do 
    create_list(:merchant, 10)

    get '/api/v1/merchants'

    expect(response).to be_successful 


    merchants = JSON.parse(response.body, symbolize_names: true)



    # merchants.each do |m|
    #   expect(m).to have_key(:id)
    #   expect(m[:id]).to be_an(Integer)
    # end
  end
end 