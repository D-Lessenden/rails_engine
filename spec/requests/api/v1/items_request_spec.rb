require 'rails_helper'
require 'faker'


describe "Items API" do
  it "sends a list of items" do
    create_list(:item, 3)

    get '/api/v1/items'
    expect(response).to be_successful
    items = JSON.parse(response.body)
    expect(items["data"].count).to eq(3)
  end

  it "can get one item by its id" do
   id = create(:item).id

   get "/api/v1/items/#{id}"

   item = JSON.parse(response.body)
   expect(response).to be_successful
   expect(item["data"]["id"].to_i).to eq(id)
 end

 it "can create a new item" do
   merchant = create(:merchant)
   item_params = {
     name: 'Saw',
     description: 'Do you want to play a game?',
     unit_price: 100,
     merchant_id: merchant.id,
   }

   headers = { 'CONTENT_TYPE' => 'application/json' }
   post '/api/v1/items', headers: headers, params: JSON.generate(item_params)
   item = Item.last
   expect(response).to be_successful
   expect(item.name).to eq(item_params[:name])
   expect(item.description).to eq(item_params[:description])
   expect(item.unit_price).to eq(item_params[:unit_price])
   expect(item.merchant_id).to eq(item_params[:merchant_id])
  end

  it "can update an existing item" do
    merchant = create(:merchant)
    item = merchant.items.create({
      name: 'Saw',
      description: 'Do you want to play a game?',
      unit_price: 100,
      merchant_id: merchant.id,
    })
    previous_name = Item.last.name

    item_params = { name: "Sledge" }
    headers = {"CONTENT_TYPE" => "application/json"}

    put "/api/v1/items/#{item.id}", headers: headers, params: JSON.generate(item_params)
    updated_item = Item.find_by(id: item.id)

    expect(response).to be_successful
    expect(updated_item.name).to_not eq(previous_name)
    expect(updated_item.name).to eq("Sledge")
  end

  it "can destroy an item" do
    item = create(:item)

    expect(Item.count).to eq(1)

    delete "/api/v1/items/#{item.id}"

    expect(response).to be_successful
    expect(Item.count).to eq(0)
    expect{Item.find(item.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end

  it "can destroy an item" do
    item = create(:item)

    expect{ delete "/api/v1/items/#{item.id}" }.to change(Item, :count).by(-1)

    expect(response).to be_successful
    expect{Item.find(item.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end
end
