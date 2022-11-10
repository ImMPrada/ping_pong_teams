class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :username, null: false
      t.string :email, null: false

      t.timestamps
      t.index :username, unique: true
      t.index :email, unique: true
    end
  end
end
