class AddPayerIdToClients < ActiveRecord::Migration[5.2]
  def change
    add_column :clients, :payer_id, :string
  end
end
