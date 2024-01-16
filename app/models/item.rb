class Item < ApplicationRecord

  # アソシエーション
  belongs_to :genre
  
  # ActiveStorage宣言
  has_one_attached :image

end
