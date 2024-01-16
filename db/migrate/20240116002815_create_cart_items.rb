class CreateCartItems < ActiveRecord::Migration[6.1]
  def change
    create_table :cart_items do |t|
      
      # テーブル定義書[カート]より作成
      t.integer :item_id
      t.integer :customer_id
      t.integer :amount

      t.timestamps
    end
  end
end
