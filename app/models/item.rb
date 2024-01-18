class Item < ApplicationRecord
  scope :active, -> { where(is_active: true) }

  # アソシエーション
  belongs_to :genre, optional: true

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

end
