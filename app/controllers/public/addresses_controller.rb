class Public::AddressesController < ApplicationController
before_action :authenticate_customer!

  def create
    @address = Address.new(address_params)
    if @address.save
      flash[:notice] = "新規登録が完了しました。"
      redirect_to addresses_path
    else
      flash.now[:notice] = "新規登録に失敗しました。"
      render :index
    end
  end

  def index
    @address = Address.new
    @addresses = Address.where(customer_id: current_customer.id)
  end

  def edit
    @address = Address.find(current_customer.id)
  end

  def update
    @address = Address.find(current_customer.id)
    if @address.update(address_params)
      flash[:notice] = "編集が完了しました。"
      redirect_to addresses_path
    else
      flash.now[:notice] = "編集が失敗しました。"
      render :edit
    end
  end

  def destroy
    @address = Address.find(current_customer.id)
    if @address.destroy
      flash[:notice] = "削除しました。"
      redirect_to addresses_path
    else
      flash.now[:notice] = "削除に失敗しました。"
      render :index
    end
  end

private
  def address_params
    params.require(:address).permit(:customer_id, :postal_code, :address, :name)
  end

end
