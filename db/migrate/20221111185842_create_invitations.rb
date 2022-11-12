class CreateInvitations < ActiveRecord::Migration[7.0]
  def change
    create_table :invitations do |t|
      t.references :sender, null: false, foreign_key: { to_table: :users }
      t.references :recipient, null: false, foreign_key: { to_table: :users }
      t.references :team, null: false, foreign_key: true
      t.boolean :active, default: false, null: false
      t.boolean :accepted

      t.timestamps
    end
  end
end
