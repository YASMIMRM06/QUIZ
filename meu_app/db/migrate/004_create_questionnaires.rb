class CreateQuestionnaires < ActiveRecord::Migration[7.0]
  def change
    create_table :questionnaires, id: :uuid do |t|
      t.string :code, null: false
      t.string :title, null: false
      t.string :description
      t.integer :duration_minutes
      t.timestamps
      t.timestamp :deleted_at
    end

    add_index :questionnaires, :code, unique: true
  end
end