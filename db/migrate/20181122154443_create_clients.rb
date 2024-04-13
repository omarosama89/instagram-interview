class CreateClients < ActiveRecord::Migration[5.2]
  def change
    create_table :clients do |t|
      t.string :email
      t.string :phone_number
      t.string :first_name
      t.string :last_name

      t.timestamps
    end
  end
end
