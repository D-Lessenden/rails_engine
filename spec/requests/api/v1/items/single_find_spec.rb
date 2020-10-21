require 'rails_helper'

describe 'can find a single merchant with a set of criteria' do
  it 'can find matches with name' do
    item1 = create(:item, name: "apple")
    item2 = create(:item, name: "banana")
    attribute = 'name'
    value = 'banana'

    get "/api/v1/items/find?#{attribute}=#{value}"
    expect(response).to be_successful

    item = JSON.parse(response.body, symbolize_names: true)[:data]
    expect(item.keys).to eq([:id, :type, :attributes, :relationships])
    expect(item[:attributes][:name]).to eq(item2.name)
  end

  it 'can find matches with a description' do
    item1 = create(:item, name: "apple", description: "this is a great apple")
    item2 = create(:item, name: "banana", description: "this is a terrible banana")
    attribute = 'description'
    value = 'terrible'

    get "/api/v1/items/find?#{attribute}=#{value}"
    expect(response).to be_successful

    item = JSON.parse(response.body, symbolize_names: true)[:data]
    expect(item.keys).to eq([:id, :type, :attributes, :relationships])
    expect(item[:attributes][:name]).to eq(item2.name)
    expect(item[:attributes][:description]).to eq(item2.description)
  end

  it 'can find matches with a unit price' do
    item1 = create(:item, name: "apple", description: "this is a great apple", unit_price: 101.10)
    item2 = create(:item, name: "banana", description: "this is a terrible banana", unit_price: 99.99)
    attribute = 'unit_price'
    value = 99.99

    get "/api/v1/items/find?#{attribute}=#{value}"
    expect(response).to be_successful

    item = JSON.parse(response.body, symbolize_names: true)[:data]
    expect(item.keys).to eq([:id, :type, :attributes, :relationships])
    expect(item[:attributes][:name]).to eq(item2.name)
    expect(item[:attributes][:description]).to eq(item2.description)
    expect(item[:attributes][:unit_price]).to eq(item2.unit_price)
  end

  it 'can find matches with a created or updated at' do
    item1 = create(:item, name: "apple", description: "this is a great apple", unit_price: 101.10, updated_at: "2012-03-27 14:54:03")
    item2 = create(:item, name: "banana", description: "this is a terrible banana", unit_price: 99.99, updated_at: "2014-03-27 14:54:03")
    attribute = 'updated_at'
    value = "2014"

    get "/api/v1/items/find?#{attribute}=#{value}"
    expect(response).to be_successful
    item = JSON.parse(response.body, symbolize_names: true)[:data]
    expect(item.keys).to eq([:id, :type, :attributes, :relationships])
    expect(item[:attributes][:name]).to eq(item2.name)
    expect(item[:attributes][:description]).to eq(item2.description)
    expect(item[:attributes][:unit_price]).to eq(item2.unit_price)
  end


end
