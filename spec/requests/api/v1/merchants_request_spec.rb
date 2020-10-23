require 'rails_helper'

describe "Merchants API" do
  it "sends a list of merchants" do
    create_list(:merchant, 3)

    get '/api/v1/merchants'

    expect(response).to be_successful
    merchants = JSON.parse(response.body)
    expect(merchants["data"].count).to eq(3)
  end

  it "can get one merchant by its id" do
   id = create(:merchant).id

   get "/api/v1/merchants/#{id}"

   merchant = JSON.parse(response.body)
   expect(response).to be_successful
   expect(merchant["data"]["id"].to_i).to eq(id)
 end

 it "can create a new merchant" do


  merchant_params = {name: 'some name'}
  headers = { 'CONTENT_TYPE' => 'application/json' }
  post '/api/v1/merchants', headers: headers, params: JSON.generate(merchant_params)
  merchant = Merchant.last

  expect(response).to be_successful
  expect(merchant.name).to eq(merchant_params[:name])
end

  it "can update an existing merchant" do
    merchant = create(:merchant)

    merchant_params = { name: 'some other name' }
    headers = { 'CONTENT_TYPE' => 'application/json' }
    patch "/api/v1/merchants/#{merchant.id}", headers: headers, params: JSON.generate(merchant_params)
    updated_merchant = Merchant.find_by(id: merchant.id)
    expect(response).to be_successful
    expect(updated_merchant.name).to_not eq(merchant.name)
    expect(updated_merchant.name).to eq('some other name')
  end

  it "can destroy an merchant" do
    merchant = create(:merchant)

    expect(Merchant.count).to eq(1)

    delete "/api/v1/merchants/#{merchant.id}"

    expect(response).to be_successful
    expect(Merchant.count).to eq(0)
    expect{Merchant.find(merchant.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end

  it "can destroy an merchant" do
    merchant = create(:merchant)

    expect{ delete "/api/v1/merchants/#{merchant.id}" }.to change(Merchant, :count).by(-1)

    expect(response).to be_successful
    expect{Merchant.find(merchant.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end
end
