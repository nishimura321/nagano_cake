class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

  def new
    @order = Order.new
  end

  def create
    order = Order.new(order_params)
    order.save
    redirect_to oeders_thanks_path
  end

  def index
  end

  def show
  end

  def confirm
    @order = Order.new(order_params)
    @order.postal_code = current_customer.postal_code
    @order.address = current_customer.address
    @order.name = current_customer.last_name + current_customer.first_name
    @cart_items = current_customer.cart_item
    #合計を求める
    @total_price = 0
    @cart_items.each do |cart_item|
      @total_price += cart_item.subtotal
    end
    @order.shipping_fee = 800
    @order.total_payment = @order.shipping_fee + @total_price
  end

  def thanks
  end

  private
  def order_params
    params.require(:order).permit(:postal_code, :address, :name, :shipping_fee, :total_payment, :payment_method)
  end

end
