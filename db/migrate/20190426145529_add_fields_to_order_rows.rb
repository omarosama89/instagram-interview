class AddFieldsToOrderRows < ActiveRecord::Migration[5.2]
  def change
    add_column :order_rows, :net, :float
    add_column :order_rows, :transaction_id, :string
    add_column :order_rows, :client_ip, :string
    add_column :order_rows, :created_by_admin, :boolean
  end
end
