class CartItem < ApplicationRecord

  # アソシエーション
  belongs_to :customer

  belongs_to :item
  
  def self.cart_items_total_price(cart_items)
    cart_items.sum { |cart_item| cart_item.item.price * cart_item.amount }
  end
end
