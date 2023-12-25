class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

  def new
    @order = Order.new
  end

  def create
    order = Order.new(order_params)
    order.save
    redirect_to orders_confirm_path
  end

  def index
  end

  def show
  end

  def confirm
  end

  def thanks
  end

  private
  def order_params
    params.require(:order).permit(:postal_code, :address, :name, :shipping_fee, :total_payment, :payment_methode)
  end
  
end
