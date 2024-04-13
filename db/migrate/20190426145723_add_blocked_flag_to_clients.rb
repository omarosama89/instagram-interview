class AddBlockedFlagToClients < ActiveRecord::Migration[5.2]
  def change
    add_column :clients, :blocked_flag, :boolean
  end
end
