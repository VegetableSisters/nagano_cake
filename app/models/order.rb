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
  
  enum production_status: {
    not_started: 0,
    waiting_for_production: 1,
    in_production: 2,
    production_completed: 3
  }

  enum shipping_status: {
    payment_pending: 0,
    payment_confirmed: 1,
    being_prepared: 2,
    preparing_for_shipping: 3,
    shipped: 4
  }


  after_initialize :set_default_status, if: :new_record?

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

  def set_default_status
    self.status ||= :payment_pending
  end

  def order_status_i18n
    I18n.t("order.order_statuses.#{order_status}")
  end
end
