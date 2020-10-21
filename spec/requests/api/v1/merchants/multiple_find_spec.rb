require 'rails_helper'

describe 'can find mulitple merchants with a set of criteria' do
  it 'can find matches' do
  merchant1 = create(:merchant, name: "walmart")
  merchant2 = create(:merchant, name: "target")
  merchant3 = create(:merchant, name: "king sooper's")
  merchant4 = create(:merchant, name: "home depot")
  merchant5 = create(:merchant, name: "flower depot")


  attribute = "name"
  value = "depot"

  get "/api/v1/merchants/find_all?#{attribute}=#{value}"
  expect(response).to be_successful
  merchants = JSON.parse(response.body, symbolize_names: true)[:data]
  expect(merchants.count).to eq(2)
  expect(merchants.first[:attributes][:name]).to eq(merchant4.name)
  expect(merchants.last[:attributes][:name]).to eq(merchant5.name)
  end

  it 'can find matches with a created or updated at' do
  merchant1 = create(:merchant, name: "walmart", updated_at: "2012-03-27 14:54:03")
  merchant2 = create(:merchant, name: "target", updated_at: "2013-03-27 14:54:03")
  merchant3 = create(:merchant, name: "king sooper's", updated_at: "2014-03-27 14:54:03")
  merchant4 = create(:merchant, name: "home depot", updated_at: "2015-03-27 14:54:03")
  merchant5 = create(:merchant, name: "flower depot", updated_at: "2015-03-27 14:54:03")


  attribute = "updated_at"
  value = "2015"

  get "/api/v1/merchants/find_all?#{attribute}=#{value}"
  expect(response).to be_successful
  merchants = JSON.parse(response.body, symbolize_names: true)[:data]
  expect(merchants.count).to eq(2)
  expect(merchants.first[:attributes][:name]).to eq(merchant4.name)
  expect(merchants.last[:attributes][:name]).to eq(merchant5.name)
  end
end
