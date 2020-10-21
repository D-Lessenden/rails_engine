require 'rails_helper'

describe 'Return all items associated with merchant' do
  it 'retrieve all items' do
    id = create(:merchant).id
    create_list(:item, 3, merchant_id: "#{id}")
    create_list(:item, 5)

    get "/api/v1/merchants/#{id}/items"

    expect(response).to be_successful
    items = JSON.parse(response.body, symbolize_names: true)[:data]
    expect(Item.all.length).to eq(8)
    expect(Merchant.first.items.length).to eq(3)
  end
end
