class Api::V1::ItemsController < ApplicationController
  def index
    render json: ItemSerializer.new(Item.all)
    # Item.all
  end

  def show
    # render json: Item.find(params[:id])
    render json: ItemSerializer.new(Item.find(params[:id]))
  end

  def create
    # render json: ItemSerializer.new(Item.create({
    #   params[:name]
    #   params[:description]
    #   params[:unit_price]
    #   params[:merchant_id]
    #
    #   }))
    a = render json: Item.create(item_params)

  end

  def update
    # render json: ItemSerializer.new(Item.update(params[:id], item_params))
    render json: Item.update(params[:id], item_params)
  end

  def destroy
    # render json: ItemSerializer.new(Item.delete(params[:id])
    render json: Item.delete(params[:id])
  end

  private
  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end
end
