class Public::ItemsController < ApplicationController
  def index
    @item_count = Item.where(is_sold: true).count
    @items = Item.where(is_sold: true).page(params[:page]).per(8)
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end
end
