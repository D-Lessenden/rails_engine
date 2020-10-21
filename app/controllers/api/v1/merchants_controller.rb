class Api::V1::MerchantsController < ApplicationController
  def index
    render json: MerchantSerializer.new(Merchant.all)
  end

  def show
    render json: MerchantSerializer.new(Merchant.find(params[:id]))
  end

  def create
    ActiveRecord::Base.connection.reset_pk_sequence!('merchants')
    new = Merchant.new(merchant_params)
    render json: MerchantSerializer.new(new) if new.save
  end

  def update
    render json: MerchantSerializer.new(Merchant.update(params[:id], merchant_params))
  end

  def destroy
    Merchant.destroy(params[:id])
  end

  private
  def merchant_params
    params.permit(:name, :created_at, :updated_at)
  end
end
