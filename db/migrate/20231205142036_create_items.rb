class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.text :introduction, null: false
      t.integer :price, null: false
      # 以下チャレンジ機能
      t.integer :genre_id, null: false
      def change
      change_column :items, :is_sold, :boolean, default: 'TRUE', null: false
      end

      t.timestamps
    end
  end
end
