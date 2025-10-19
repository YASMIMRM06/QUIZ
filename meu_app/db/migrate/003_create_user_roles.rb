class CreateUserRoles < ActiveRecord::Migration[7.0]
  def change
    create_table :user_roles, id: :uuid do |t|
      t.uuid :user_id, null: false
      t.uuid :role_id, null: false

      t.timestamps
    end

    add_foreign_key :user_roles, :users, column: :user_id
    add_foreign_key :user_roles, :roles, column: :role_id
  end
end
