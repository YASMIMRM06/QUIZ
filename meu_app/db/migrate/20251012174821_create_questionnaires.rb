class CreateQuestionnaires < ActiveRecord::Migration[7.1]
  def change
    create_table :questionnaires do |t|
      t.string :code
      t.string :title
      t.string :description
      t.integer :duration_minutes
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
