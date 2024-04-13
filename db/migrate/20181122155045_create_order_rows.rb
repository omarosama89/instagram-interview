class CreateOrderRows < ActiveRecord::Migration[5.2]
  def change
    create_table :order_rows do |t|
      t.string :order_code
      t.boolean :verified, default: false
      t.belongs_to :service, foreign_key: true
      t.belongs_to :client, foreign_key: true

      t.timestamps
    end
  end
end
