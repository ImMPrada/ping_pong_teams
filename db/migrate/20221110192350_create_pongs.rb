class CreatePongs < ActiveRecord::Migration[7.0]
  def change
    create_table :pongs do |t|
      t.references :user, null: false, foreign_key: true
      t.references :ping, null: false, foreign_key: true

      t.timestamps
    end
  end
end
