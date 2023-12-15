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
    @items = Item.page(params[:page])
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      flash[:notice] = "変更を保存しました。"
      redirect_to admin_item_path(@item)
    else
      flash.now[:notice] = "変更の保存に失敗しました。"
      render :edit
    end
  end

  private
  def item_params
    params.require(:item).permit(:genre_id, :name, :introduction, :price, :is_sold, :image)
  end

end
