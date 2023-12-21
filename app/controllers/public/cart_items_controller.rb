class Public::CartItemsController < ApplicationController
before_action :authenticate_customer!

  def create
    cart_item = CartItem.new(cart_item_params)
    cart_item.save
    redirect_to cart_items_path
  end

  def index
    @cart_items = current_customer.cart_items
    #合計を求める
    @total_price = 0
    @cart_items.each do |cart_item|
      @total_price += item.subtotal
    end
  end

  def update
    @cart_item = CartItem.find(params[:id])
    if @cart_item.update(cart_item_params)
      flash.now[:notice] = "変更を保存しました。"
      render :index
    else
      flash.now[:notice] = "変更の保存に失敗しました。"
      render :index
    end
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    flash.now[:notice] = "削除しました。"
    render :index
  end

  def destroy_all
    current_customer.cart_items.destroy_all
    flash[:notice] = "カートを空にしました"
    render :index
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end

end
