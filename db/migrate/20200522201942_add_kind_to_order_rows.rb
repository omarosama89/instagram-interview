class AddKindToOrderRows < ActiveRecord::Migration[5.2]
  def change
    add_column :order_rows, :kind, :integer, default: 0   # default is web
  end
end
