class Api::V1::SearchController < ApplicationController
  def find_merchant
    merchant = Merchant.find_merch(params[:name])

    render json: MerchantSerializer.format_merchant(merchant)
  end

  def find_items
  end
end
