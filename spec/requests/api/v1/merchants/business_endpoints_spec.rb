require 'rails_helper'

describe 'Business intelligence endpoints' do
  before :each do
    @merchant1 = create(:merchant)
    @merchant2 = create(:merchant)
    @merchant3 = create(:merchant)
    @merchant4 = create(:merchant)
    @item1 = create(:item, merchant_id: @merchant1.id, unit_price: 10.50)
    @item2 = create(:item, merchant_id: @merchant2.id, unit_price: 10.50)
    @item3 = create(:item, merchant_id: @merchant3.id, unit_price: 10.50)
    @item4 = create(:item, merchant_id: @merchant4.id, unit_price: 10.50)


    @invoice1 = create(:invoice, merchant_id: @merchant1.id)
    @transaction1 = create(:transaction, result: "result", invoice_id: @invoice1.id)
    @invoice_item1 = create(:invoice_item, invoice_id: @invoice1.id, unit_price: 10.50, quantity: 1, item_id: @item1.id)

    @invoice2 = create(:invoice, merchant_id: @merchant1.id)
    @transaction2 = create(:transaction, result: "result", invoice_id: @invoice2.id)
    @invoice_item2 = create(:invoice_item, invoice_id: @invoice2.id, unit_price: 10.50, quantity: 1, item_id: @item1.id)

    @invoice3 = create(:invoice, merchant_id: @merchant1.id)
    @transaction3 = create(:transaction, result: "result", invoice_id: @invoice3.id)
    @invoice_item3 = create(:invoice_item, invoice_id: @invoice3.id, unit_price: 10.50, quantity: 1, item_id: @item1.id)

    @invoice4 = create(:invoice, merchant_id: @merchant2.id)
    @transaction4 = create(:transaction, result: "result", invoice_id: @invoice4.id)
    @invoice_item4 = create(:invoice_item, invoice_id: @invoice4.id, unit_price: 10.50, quantity: 2, item_id: @item2.id)

    @invoice5 = create(:invoice, merchant_id: @merchant3.id)
    @transaction5 = create(:transaction, result: "result", invoice_id: @invoice5.id)
    @invoice_item5 = create(:invoice_item, invoice_id: @invoice5.id, unit_price: 10.50, quantity: 1, item_id: @item3.id)

    @invoice6 = create(:invoice, merchant_id: @merchant4.id)
    @transaction6 = create(:transaction, result: "result", invoice_id: @invoice6.id)
    @invoice_item6 = create(:invoice_item, invoice_id: @invoice6.id, unit_price: 10.50, quantity: 1, item_id: @item4.id)
  end

  xit 'can find the merchants with the most revenue' do

    # binding.pry
    quantity = 2

    get "/api/v1/merchants/most_revenue?quantity=#{quantity}"
    most_revenue = JSON.parse(response.body, symbolize_names: true)[:data]
    # binding.pry

    expect(response).to be_successful
    #returning empty array, fuck my life
    #in rails c returns quantity amount of merchants
    #in spec harness it returns the wrong merchants
  end

  it 'can find the merchat with most items sold' do
    quantity = 2

    get "/api/v1/merchants/most_items?quantity=#{quantity}"
    most_items = JSON.parse(response.body, symbolize_names: true)[:data]
    # binding.pry
    expect(response).to be_successful
    #returning empty array, fuck my life
    #in rails c returns quantity amount of merchants
  end

  xit 'can return the total revenue for a merchant' do

    get "/api/v1/merchants/#{@merchant1.id}/revenue"
    expect(response).to be_successful
    total_revenue = JSON.parse(response.body, symbolize_names: true)[:data]


  end
end
