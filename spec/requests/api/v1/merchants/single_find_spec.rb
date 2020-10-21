require 'rails_helper'

describe 'can find a single merchant with a set of criteria' do
  it 'can find matches with name' do
  merchant1 = create(:merchant, name: "walmart", created_at: "2012-03-27 14:54:03")
  merchant2 = create(:merchant, name: "target")
  merchant3 = create(:merchant, name: "king sooper's")
  merchant4 = create(:merchant, name: "home depot")

  attribute = "name"
  value = "target"

  get "/api/v1/merchants/find?#{attribute}=#{value}"
  expect(response).to be_successful
  merchant = JSON.parse(response.body, symbolize_names: true)[:data]
  expect(merchant.keys).to eq([:id, :type, :attributes])
  expect(merchant[:attributes][:name]).to eq('target')
  end

  it 'can find matches with created_at or updated_at' do
  merchant1 = create(:merchant, name: "walmart", created_at: "2012-03-27 14:54:03")
  merchant2 = create(:merchant, name: "target", created_at: "2016-03-27 14:54:03")
  merchant3 = create(:merchant, name: "king sooper's", created_at: "2016-03-27 14:54:03")
  merchant4 = create(:merchant, name: "home depot", created_at: "2016-03-27 14:54:03")

  attribute = "created_at"
  value = "2012-03-27 14:54:03"
  get "/api/v1/merchants/find?#{attribute}=#{value}"
  expect(response).to be_successful
  merchant = JSON.parse(response.body, symbolize_names: true)[:data]
  end
end
