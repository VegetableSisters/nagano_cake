class Order < ApplicationRecord
  
  # アソシエーション
  # 親である注文が削除されると、子の注文詳細も削除される
  belongs_to :registered_address, class_name: 'Address', foreign_key: 'registered_address_id', optional: true
  attr_accessor :new_postal_code, :new_address, :new_name, :registered_address_id
  
  enum address_type: {
    customer_address: "customer_address",
    registered_address: "registered_address",
    new_address: "new_address"
  }
  
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
