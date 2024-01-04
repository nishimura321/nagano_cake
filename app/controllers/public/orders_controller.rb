class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

  def new
    @order = Order.new
  end

  def create
    order = Order.new(order_params)
    order.save
    @cart_items = current_customer.cart_item
    @cart_items.each do |cart_item|
      @order_details = OrderDetail.new
      @order_details.order_id = order.id
      @order_details.item_id = cart_item.item.id
      @order_details.price = cart_item.item.add_tax_price
      @order_details.amount = cart_item.amount
      @order_details.save
    end
    CartItem.destroy_all
    redirect_to orders_thanks_path
  end

  def index
    @orders = Order.order(created_at: :desc).all
  end

  def show
    @order = Order.find(params[:id])
    @total_price = @order.total_payment - @order.shipping_fee
  end

  def confirm
    @order = Order.new(order_params)
    if params[:order][:select_address] == "0"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
      @cart_items = current_customer.cart_item
    elsif params[:order][:select_address] == "1"
      @address = Address.find(params[:order][:address_id])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name
    elsif params[:order][:select_address] == "2"
      @order.postal_code = params[:order][:postal_code]
      @order.address = params[:order][:address]
      @order.name = params[:order][:name]
    end
    #合計を求める
    @cart_items = current_customer.cart_item
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
    params.require(:order).permit(:postal_code, :address, :name, :shipping_fee, :total_payment, :payment_method, :customer_id)
  end

end
