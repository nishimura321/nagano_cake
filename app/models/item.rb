class Item < ApplicationRecord
  has_one_attached :image
  belongs_to :genre
  has_many :cart_item, dependent: :destroy
  has_many :order_detall, dependent: :destroy

  #税込価格を表示させる
  def add_tax_price
  (self.price * 1.10).round
  end
end
