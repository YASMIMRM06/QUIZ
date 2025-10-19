class CreateRoles < ActiveRecord::Migration[7.0]
  def change
    create_table :roles, id: :uuid do |t|
      t.string :title, null: false
      t.timestamps
      t.timestamp :deleted_at
    end
  end
end