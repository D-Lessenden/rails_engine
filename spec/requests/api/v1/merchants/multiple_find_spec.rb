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
  end
end
