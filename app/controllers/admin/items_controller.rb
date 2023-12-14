class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      flash[:notice] = "新規登録が完了しました。"
      redirect_to admin_item_path(@item)
    else
      flash.now[:notice] = "新規登録に失敗しました。"
      render :new
    end
  end

  def index
    @items = Item.all
  end

  def show
  end

  def edit
  end

  def update
  end

  private
  def item_params
    params.require(:item).permit(:genre_id, :name, :introduction, :price, :is_sold, :image)
  end

end
