require 'rails_helper'

describe 'can find multiple items with a set of criteria' do
  it 'can find matches with name' do
    item1 = create(:item, name: 'apple')
    item2 = create(:item, name: 'banana')
    item3 = create(:item, name: 'blueberry')
    item4 = create(:item, name: 'strawberry')
    item5 = create(:item, name: 'watermelon')
    item6 = create(:item, name: 'potato')

    attribute = 'name'
    value = 'berry'

    get "/api/v1/items/find_all?#{attribute}=#{value}"
    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)[:data]
    expect(items.count).to eq(2)
    expect(items.first[:attributes][:name]).to eq(item3.name)
    expect(items.last[:attributes][:name]).to eq(item4.name)
  end

  it 'can find mulitple matches with a description' do
    item1 = create(:item, name: "apple", description: "this is a great apple")
    item2 = create(:item, name: "banana", description: "this is a terrible banana")
    item3 = create(:item, name: 'blueberry', description: "a vine fruit that is blue")
    item4 = create(:item, name: 'strawberry', description: "a vine fruit that is red")
    item5 = create(:item, name: 'watermelon', description: "a melon containing a high volumn of water")
    item6 = create(:item, name: 'potato', description: "basically a carrot")
    attribute = 'description'
    value = 'vine'

    get "/api/v1/items/find_all?#{attribute}=#{value}"
    expect(response).to be_successful
    items = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(items.count).to eq(2)
    expect(items.first[:attributes][:name]).to eq(item3.name)
    expect(items.last[:attributes][:name]).to eq(item4.name)
    expect(items.first[:attributes][:description]).to eq(item3.description)
    expect(items.last[:attributes][:description]).to eq(item4.description)

  end

  it 'can find multiple matches with a unit price' do
    item1 = create(:item, name: "apple", description: "this is a great apple", unit_price: 10.99)
    item2 = create(:item, name: "banana", description: "this is a terrible banana", unit_price: 14.99)
    item3 = create(:item, name: 'blueberry', description: "a vine fruit that is blue", unit_price: 134.01)
    item4 = create(:item, name: 'strawberry', description: "a vine fruit that is red", unit_price: 134.01)
    item5 = create(:item, name: 'watermelon', description: "a melon containing a high volumn of water", unit_price: 65.98)
    item6 = create(:item, name: 'potato', description: "basically a carrot", unit_price: 87.43)
    attribute = 'unit_price'
    value = 134.01

    get "/api/v1/items/find_all?#{attribute}=#{value}"
    expect(response).to be_successful
    items = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(items.count).to eq(2)
    expect(items.first[:attributes][:name]).to eq(item3.name)
    expect(items.last[:attributes][:name]).to eq(item4.name)
    expect(items.first[:attributes][:description]).to eq(item3.description)
    expect(items.last[:attributes][:description]).to eq(item4.description)
    expect(items.first[:attributes][:unit_price]).to eq(item3.unit_price)
    expect(items.last[:attributes][:unit_price]).to eq(item4.unit_price)
  end

  it 'can find matches with a created or updated at' do
    item1 = create(:item, name: "apple", description: "this is a great apple", unit_price: 10.99, updated_at: "2012-03-27 14:54:03")
    item2 = create(:item, name: "banana", description: "this is a terrible banana", unit_price: 14.99, updated_at: "2013-03-27 14:54:03")
    item3 = create(:item, name: 'blueberry', description: "a vine fruit that is blue", unit_price: 134.01, updated_at: "2014-03-27 14:54:03")
    item4 = create(:item, name: 'strawberry', description: "a vine fruit that is red", unit_price: 134.01, updated_at: "2014-03-27 14:54:03")
    item5 = create(:item, name: 'watermelon', description: "a melon containing a high volumn of water", unit_price: 65.98, updated_at: "2015-03-27 14:54:03")
    item6 = create(:item, name: 'potato', description: "basically a carrot", unit_price: 87.43, updated_at: "2016-03-27 14:54:03")
    attribute = 'updated_at'
    value = "2014"

    get "/api/v1/items/find_all?#{attribute}=#{value}"
    expect(response).to be_successful
    items = JSON.parse(response.body, symbolize_names: true)[:data]
    expect(items.count).to eq(2)
    expect(items.first[:attributes][:name]).to eq(item3.name)
    expect(items.last[:attributes][:name]).to eq(item4.name)
    expect(items.first[:attributes][:description]).to eq(item3.description)
    expect(items.last[:attributes][:description]).to eq(item4.description)
    expect(items.first[:attributes][:unit_price]).to eq(item3.unit_price)
    expect(items.last[:attributes][:unit_price]).to eq(item4.unit_price)
  end
end
