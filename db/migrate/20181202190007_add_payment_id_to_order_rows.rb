class AddPaymentIdToOrderRows < ActiveRecord::Migration[5.2]
  def change
    add_column :order_rows, :payment_id, :string
  end
end
