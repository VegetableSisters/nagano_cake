class Order < ApplicationRecord
  has_many :order_details

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
  
  enum status: {
    payment_pending: "入金待ち",
    payment_confirmed: "入金確認",
    in_production: "製作中",
    preparing_for_shipping: "発送準備中",
    shipped: "発送済み"
  }

  has_many :order_details, dependent: :destroy
  
  def y_to_d
    created_at.to_date.strftime("%Y/%m/%d")
  end

  def self.payment_methods_i18n
    {
      credit_card: "クレジットカード",
      transfer: "銀行振込"
      # 他の支払い方法を追加する場合はここに追加
    }
  end

  
  def postal_code_and_address_and_name
    "#{postal_code} #{address} #{name}"
  end


end
