class CreateUserResults < ActiveRecord::Migration[7.0]
  def change
    create_table :user_results, id: :uuid do |t|
      t.uuid :user_id, null: false
      t.uuid :questionnaire_id, null: false
      t.integer :correct_answers, null: false
      t.integer :total_questions, null: false
      t.decimal :score, null: false
      t.timestamp :submitted_at, null: false
      t.timestamps
      t.timestamp :deleted_at
    end

    add_foreign_key :user_results, :users, column: :user_id
    add_foreign_key :user_results, :questionnaires
  end
end
