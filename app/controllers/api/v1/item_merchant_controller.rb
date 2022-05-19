class Api::V1::ItemMerchantController < ApplicationController
  def index
    item = Item.find(params[:item_id])
    merchant = Merchant.find(item.merchant_id)
    render json: MerchantSerializer.format_merchant(merchant)
  end
end
