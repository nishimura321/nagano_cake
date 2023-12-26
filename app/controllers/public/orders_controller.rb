class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

  def new
    @order = Order.new(customer_id: current_customer.id)
  end

  def create
    customer = Customer.find(current_customer.id)
    @order = Order.new(
    postal_code: customer.postal_code,
    address: customer.address,
    name: "#{customer.last_name} #{customer.first_name}"
    )

    if @order.save
      redirect_to orders_confirm_path
    else
      render :new
    end
  end

  def index
  end

  def show
  end

  def confirm
    @cart_items = current_customer.cart_item
    #合計を求める
    @total_price = 0
    @cart_items.each do |cart_item|
      @total_price += cart_item.subtotal
    end
  end

  def thanks
  end

  private
  def order_params
    params.require(:order).permit(:postal_code, :address, :name, :shipping_fee, :total_payment, :payment_methode)
  end

end
