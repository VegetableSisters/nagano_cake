class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      
      # テーブル定義書[注文]より作成
      t.integer :customer_id
      t.string :postal_code
      t.string :address
      t.string :name
      t.integer :shipping_cost
      t.integer :total_payment
      t.integer :payment_method
      t.integer :status, default: 0
    

      t.timestamps
    end
  end
end
