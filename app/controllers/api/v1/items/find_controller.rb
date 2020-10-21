class Api::V1::Items::FindController < ApplicationController
  def show
    render json: ItemSerializer.new(Item.single_finder(attribute, value))
  end

  private
  def search_params
    params.permit(:name, :description, :unit_price, :updated_at, :created_at)
  end

  def attribute
    search_params.keys.first
  end

  def value
    search_params[attribute]
  end
end
