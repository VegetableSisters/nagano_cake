class Item < ApplicationRecord

  # アソシエーション
  belongs_to :genre, optional: true
  has_many :cart_item

  # ActiveStorage宣言
  has_one_attached :image

  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end

  def add_tax_price
    (self.price * 1.10).round
  end
  
 # 検索機能
  def self.ransackable_associations(auth_object = nil)
    []
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[name]
  end
end
