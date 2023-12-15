class Public::HomesController < ApplicationController

  def top
    @new_items = Item.where(is_sold: true).order(created_at: :desc).limit(4)
  end

  def about
  end

end
