class AddFieldsToClients < ActiveRecord::Migration[5.2]
  def change
    add_column :clients, :country, :string
    add_column :clients, :state, :string
    add_column :clients, :city, :string
    add_column :clients, :postal_code, :string
  end
end
