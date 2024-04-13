class CreateServices < ActiveRecord::Migration[5.2]
  def change
    create_table :services do |t|
      t.string :description
      t.string :s_type
      t.integer :service_family
      t.integer :minimum
      t.integer :maximum
      t.float :price
      t.integer :unit
      t.float :factor
      t.float :power
      t.float :intercept
      t.float :sale
      t.boolean :has_note, default: false
      t.string :note
      t.integer :req_method
      t.boolean :active, default: true
      t.boolean :custom_comments_flag, default: false
      t.belongs_to :api, foreign_key: true

      t.timestamps
    end
  end
end
