class CreateUserResults < ActiveRecord::Migration[7.0]
  def change
    create_table :user_results do |t|
      t.references :user, null: false, foreign_key: true
      t.references :questionnaire, null: false, foreign_key: true
      t.integer :correct_answers, null: false
      t.integer :total_questions, null: false
      t.decimal :score, null: false
      t.timestamp :submitted_at, null: false
      t.timestamps
      t.timestamp :deleted_at
    end
  end
end
