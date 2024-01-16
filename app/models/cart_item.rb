class CartItem < ApplicationRecord
  
  # アソシエーション
  belongs_to :customer
  
  
end
