class OrderDetail < ApplicationRecord
  belongs_to :item
  belongs_to :order
  
  # 小計を求めるメソッド
def subtotal
  price * amount
end

end
