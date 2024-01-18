class Order < ApplicationRecord
  
  # アソシエーション
  # 親である注文が削除されると、子の注文詳細も削除される
  has_many :order_details, dependent: :destroy
  
  enum payment_method: {
    credit_card: 0,
    transfer: 1
  }
  
  def self.payment_methods_i18n
    {
      credit_card: "クレジットカード",
      transfer: "銀行振込"
      # 他の支払い方法を追加する場合はここに追加
    }
  end
  
end
