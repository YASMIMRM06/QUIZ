class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users, id: false do |t|
      t.integer :id, primary_key: true
      t.string :name, null: false
      t.string :email, null: false
      t.string :password_digest, null: false  # Campo para has_secure_password
      t.string :suap_id, null: false
      t.timestamps
      t.timestamp :deleted_at
    end

    add_index :users, :email, unique: true
  end
end
