class Genre < ApplicationRecord
  #バリデーション
  validates :name, presence: true
  # アソシエーション
  has_many :items
  
   # 検索機能に検索対象のカラムを追加
  def self.ransackable_attributes(auth_object = nil)
    ["name"]
  end
  
end
