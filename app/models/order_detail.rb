class OrderDetail < ApplicationRecord
  enum shipping_status: {
    payment_pending: 0,
    payment_confirmed: 1,
    being_prepared: 2,
    preparing_for_shipping: 3,
    shipped: 4
  }
  
  enum production_status: {
    not_started: 0,
    waiting_for_production: 1,
    in_production: 2,
    production_completed: 3
  }
  belongs_to :order
  belongs_to :item

end
