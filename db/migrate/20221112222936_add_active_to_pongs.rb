class AddActiveToPongs < ActiveRecord::Migration[7.0]
  def change
    add_column :pongs, :active, :boolean, null: false, default: false
  end
end
