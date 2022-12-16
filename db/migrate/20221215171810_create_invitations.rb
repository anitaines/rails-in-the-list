class CreateInvitations < ActiveRecord::Migration[7.0]
  def change
    create_table :invitations do |t|
      t.references :list, null: false, foreign_key: true
      t.references :invitation_from, null: false, foreign_key: { to_table: :users }
      t.references :invitation_to, null: false, foreign_key: { to_table: :users }
      t.text :message

      t.timestamps
    end
  end
end
