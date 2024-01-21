class Address < ApplicationRecord
  
  # アソシエーション
  belongs_to :customer
  #バリデーション
  validates :postal_code, presence: true
  validates :address, presence: true
  validates :name, presence: true
  validates :customer_id, presence: true
  
  def address_display
    '〒' + postal_code + ' ' + address + ' ' + name
  end

end
