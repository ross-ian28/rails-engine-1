class Api::V1::ItemsController < ApplicationController
  def index
    items = Item.all
    render json: ItemSerializer.format_items(items)
  end

  def show
    item = Item.find(params[:id])
    render json: ItemSerializer.format_item(item)
  end

  def create
    item = Item.new(item_params)
    if item.save
      render json: ItemSerializer.format_item(item), status: :created
    else
      flash[:alert] = "Try again"
    end
  end

  def update
    item = Item.find(params[:id])
    if item.update(item_params)
      render json: ItemSerializer.format_item(item)
    else
      flash[:alert] = "Try again"
    end
  end

  def destroy
    Item.find(params[:id]).delete
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end
end
