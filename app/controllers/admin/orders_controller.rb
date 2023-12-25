class Admin::OrdersController < ApplicationController
before_action :authenticate_admin!

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    #合計を求める
    @total_price = 0
    @order_detail.each do |order_detail|
      @total_price += order_detail.subtotal
    end
  end

  #def update
  #end

end