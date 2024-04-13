class CreateOrderDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :order_details do |t|
      t.string :link
      t.integer :amount
      t.string :api_order_id
      t.integer :status, default: 0
      t.belongs_to :order_row, foreign_key: true

      t.timestamps
    end
  end
end
