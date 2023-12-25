class Admin::OrdersController < ApplicationController
before_action :authenticate_admin!

  def show
    @order = Order.find(params[:id])
    @order_details = OrderDetail.find(params[:id])
    #合計を求める
    @total_price = 0
    @order_detail.each do |order_detail|
      @total_price += order_detail.subtotal
  end

  #def update
  #end

end
