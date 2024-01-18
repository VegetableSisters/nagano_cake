class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|

      # テーブル定義書[商品]より作成
      t.integer :genre_id
      t.string :name
      t.text :introduction
      t.integer :price
      t.boolean :is_active, default: true

      t.timestamps
    end
  end
end
