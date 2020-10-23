require 'rails_helper'

describe 'Business intelligence endpoints' do
  before :each do
    @merchant1 = create(:merchant, name: "merchant1")
    @merchant2 = create(:merchant, name: "merchant2")
    @merchant3 = create(:merchant)
    @merchant4 = create(:merchant)
    @item1 = create(:item, merchant_id: @merchant1.id, unit_price: 10.50)
    @item2 = create(:item, merchant_id: @merchant2.id, unit_price: 10.50)
    @item3 = create(:item, merchant_id: @merchant3.id, unit_price: 10.50)
    @item4 = create(:item, merchant_id: @merchant4.id, unit_price: 10.50)


    @invoice1 = create(:invoice, merchant_id: @merchant1.id, status: "shipped")
    @transaction1 = create(:transaction, result: "success", invoice_id: @invoice1.id)
    @invoice_item1 = create(:invoice_item, invoice_id: @invoice1.id, unit_price: 10.50, quantity: 1, item_id: @item1.id)

    @invoice2 = create(:invoice, merchant_id: @merchant1.id, status: "shipped")
    @transaction2 = create(:transaction, result: "success", invoice_id: @invoice2.id)
    @invoice_item2 = create(:invoice_item, invoice_id: @invoice2.id, unit_price: 10.50, quantity: 1, item_id: @item1.id)

    @invoice3 = create(:invoice, merchant_id: @merchant1.id, status: "shipped")
    @transaction3 = create(:transaction, result: "success", invoice_id: @invoice3.id)
    @invoice_item3 = create(:invoice_item, invoice_id: @invoice3.id, unit_price: 10.50, quantity: 1, item_id: @item1.id)

    @invoice4 = create(:invoice, merchant_id: @merchant2.id, status: "shipped")
    @transaction4 = create(:transaction, result: "success", invoice_id: @invoice4.id)
    @invoice_item4 = create(:invoice_item, invoice_id: @invoice4.id, unit_price: 10.50, quantity: 2, item_id: @item2.id)

    @invoice5 = create(:invoice, merchant_id: @merchant3.id, status: "shipped")
    @transaction5 = create(:transaction, result: "success", invoice_id: @invoice5.id)
    @invoice_item5 = create(:invoice_item, invoice_id: @invoice5.id, unit_price: 10.50, quantity: 1, item_id: @item3.id)

    @invoice6 = create(:invoice, merchant_id: @merchant4.id, status: "shipped")
    @transaction6 = create(:transaction, result: "success", invoice_id: @invoice6.id)
    @invoice_item6 = create(:invoice_item, invoice_id: @invoice6.id, unit_price: 10.50, quantity: 1, item_id: @item4.id)
  end

  it 'can find the merchants with the most revenue' do
    quantity = 2

    get "/api/v1/merchants/most_revenue?quantity=#{quantity}"
    expect(response).to be_successful
    most_revenue = JSON.parse(response.body, symbolize_names: true)

    expect(most_revenue[:data].first[:id].to_i).to eq(@merchant1.id)
    expect(most_revenue[:data].first[:attributes][:name]).to eq(@merchant1.name)


    expect(most_revenue[:data].last[:id].to_i).to eq(@merchant2.id)
    expect(most_revenue[:data].last[:attributes][:name]).to eq(@merchant2.name)

  end

  it 'can find the merchat with most items sold' do
    quantity = 2

    get "/api/v1/merchants/most_items?quantity=#{quantity}"
    most_items = JSON.parse(response.body, symbolize_names: true)
    expect(response).to be_successful
    expect(most_items[:data].first[:id].to_i).to eq(@merchant1.id)
    expect(most_items[:data].first[:attributes][:name]).to eq(@merchant1.name)
  end

  xit 'can return the total revenue for a merchant' do

    get "/api/v1/merchants/#{@merchant1.id}/revenue"
    total_revenue = JSON.parse(response.body, symbolize_names: true)
     binding.pry
    expect(response).to be_successful
    #how do I test this amount ?
    #from a pry in the controller I can run this Merchant.total_revenue(merchant).first.revenue
  end
end
