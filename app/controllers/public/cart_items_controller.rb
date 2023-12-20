class Public::CartItemsController < ApplicationController
before_action :authenticate_customer!

  def create
    cart_item = CartItem.new(cart_item_params)
    cart_item.save
    redirect_to cart_items_path
  end

  def index
    @items = Item.all(params[:id])
    @cart_items = CartItem.all(current_customer.id)
  end

  def update
  end

  def destroy
  end

  def destroy_all
  end

  private
 
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end

end
