class CreateGenres < ActiveRecord::Migration[6.1]
  def change
    create_table :genres do |t|
      
      # テーブル定義書[ジャンル]より作成
      t.string :name
      
      t.timestamps
    end
  end
end
