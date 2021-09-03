class AddConfirmableToDevise < ActiveRecord::Migration[6.0]
  def up
    add_column :default_users, :confirmation_token, :string
    add_column :default_users, :confirmed_at, :datetime
    add_column :default_users, :confirmation_sent_at, :datetime
    add_index :default_users, :confirmation_token, unique: true
    add_column :default_users, :unconfirmed_email, :string #? check if needed
  end

  def down
    remove_index :default_users, :confirmation_token
    remove_columns :default_users, :confirmation_token, :confirmed_at, :confirmation_sent_at
    remove_columns :default_users, :unconfirmed_email #? check if needed
  end
end
