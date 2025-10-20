class FixUsersForDevise < ActiveRecord::Migration[7.1]
  def change
    # Estas linhas são as que você quer manter:
    remove_column :users, :password_digest, :string
    add_column :users, :encrypted_password, :string, null: false, default: ""

    # REMOVA as linhas que tentam adicionar:
    # add_column :users, :reset_password_token, :string
    # add_column :users, :reset_password_sent_at, :datetime
    # add_column :users, :remember_created_at, :datetime
    # Pois a migração anterior (20251018040615) já fez isso.
  end
end