class CreateOrderDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :order_details do |t|
      t.integer :order_id, null: false
      t.integer :item_id, null: false
      t.integer :amount, null: false
      t.integer :price, null: false
      def change
      change_column :order_details, :making_status, :integer, default: '0', null: false
      end

      t.timestamps
    end
  end
end
