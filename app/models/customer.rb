class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # ログイン時に退会済み顧客は同じアカウントでログイン出来ない
  def active_for_authentication?
    super && (is_active == true)
  end


 has_many :order, dependent: :destroy
 has_many :cart_item, dependent: :destroy
 has_many :addresses,  dependent: :destroy
end
