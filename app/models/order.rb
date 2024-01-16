class Order < ApplicationRecord
  
  # アソシエーション
  # 親である注文が削除されると、子の注文詳細も削除される
  has_many :order_details, dependent: :destroy
  
end
