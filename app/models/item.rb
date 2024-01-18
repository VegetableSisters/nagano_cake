class Item < ApplicationRecord

  # アソシエーション
  belongs_to :genre
  
  # ActiveStorage宣言
  has_one_attached :image
  
  # 検索機能に検索対象のカラムを追加
  def self.ransackable_attributes(auth_object = nil)
    ["genre", "name"]
  end

end
