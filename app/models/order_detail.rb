class OrderDetail < ApplicationRecord
  belongs_to :item
  belongs_to :order

  # 小計を求めるメソッド
def subtotal
  price * amount
end

#注文個数をトータルで表示するメソッド
def total_amount
    order_details.sum(:amount)
end

end
