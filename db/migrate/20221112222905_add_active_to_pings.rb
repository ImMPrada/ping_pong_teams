class AddActiveToPings < ActiveRecord::Migration[7.0]
  def change
    add_column :pings, :active, :boolean, null: false, default: false
  end
end
