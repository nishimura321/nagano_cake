class Public::CartItemsController < ApplicationController
before_action :authenticate_customer!

  def create
    item_id = params[:cart_item][:item_id]
    amount = params[:cart_item][:amount].to_i
    if cart_item = CartItem.find_by(item_id: item_id)
      cart_item.amount += amount
      cart_item.save
    else
      CartItem.create(item_id: item_id, amount: amount, customer_id: current_customer.id)
    end
    redirect_to cart_items_path
  end

  def index
    @cart_items = current_customer.cart_item
    #合計を求める
    @total_price = 0
    @cart_items.each do |cart_item|
      @total_price += cart_item.subtotal
    end
  end

  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
      flash[:notice] = "変更を保存しました。"
      redirect_to cart_items_path
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    flash[:notice] = "削除しました。"
    redirect_to cart_items_path
  end

  def destroy_all
    current_customer.cart_item.destroy_all
    flash[:notice] = "カートを空にしました。"
    redirect_to cart_items_path
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end

end
