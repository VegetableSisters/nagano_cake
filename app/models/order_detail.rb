class OrderDetail < ApplicationRecord
  enum production_status: {
    not_started: "着手不可",
    waiting_for_production: "製作待ち",
    in_production: "製作中",
    production_completed: "製作完了"
  }

  belongs_to :order
  belongs_to :item
  
end
