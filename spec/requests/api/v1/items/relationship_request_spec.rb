require 'rails_helper'

describe ' Retrieve the merchant that is tied to an item' do
  it 'retrieves merchant from an item' do
    merchant1 = create(:merchant)
    merchant2 = create(:merchant)

    item1 = create(:item, merchant_id: "#{merchant1.id}")
    item2 = create(:item, merchant_id: "#{merchant1.id}")
    item3 = create(:item, merchant_id: "#{merchant1.id}")

    item4 = create(:item, merchant_id: "#{merchant2.id}")
    item5 = create(:item, merchant_id: "#{merchant2.id}")
    item6 = create(:item, merchant_id: "#{merchant2.id}")

    get "/api/v1/items/#{item1.id}/merchant"
    expect(response).to be_successful
    merchant = JSON.parse(response.body, symbolize_names: true)[:data]
    expect(merchant).to have_key(:id)
    expect(merchant).to have_key(:type)
    expect(merchant[:type]).to eq("merchant")
    expect(item1.merchant).to eq(merchant1)
    expect(item6.merchant).to eq(merchant2)
  end
end
