class Api::V1::Merchants::FindController < ApplicationController

  def show
     render json: MerchantSerializer.new(Merchant.single_finder(attribute, value))
  end

  def index
     render json: MerchantSerializer.new(Merchant.multiple_finder(attribute, value))
  end

  private
  def search_params
    params.permit(:name, :updated_at, :created_at)
  end

  def attribute
    search_params.keys.first
  end

  def value
    search_params[attribute]
  end
end
