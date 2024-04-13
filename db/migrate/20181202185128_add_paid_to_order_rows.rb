class AddPaidToOrderRows < ActiveRecord::Migration[5.2]
  def change
    add_column :order_rows, :paid, :float
  end
end
