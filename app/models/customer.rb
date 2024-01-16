class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  # アソシエーション
  # 親である会員が削除されると、子である住所も削除される
  has_many :addresses, dependent: :destroy
　has_many :cart_items


end
