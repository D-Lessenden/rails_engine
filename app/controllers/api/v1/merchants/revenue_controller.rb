class Api::V1::Merchants::RevenueController < ApplicationController
  def most_revenue
   render json: MerchantSerializer.new(Merchant.most_revenue(quantity))
  end

  def most_items
    render json: MerchantSerializer.new(Merchant.most_items(quantity))
  end

  def total_revenue
    merchant = Merchant.find(params[:id])
    render json: MerchantSerializer.new(Merchant.total_revenue(merchant))
  end

  private
  def quantity
    params[:quantity].to_i
  end
end
