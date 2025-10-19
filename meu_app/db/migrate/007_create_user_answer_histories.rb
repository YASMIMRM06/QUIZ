class CreateUserAnswerHistories < ActiveRecord::Migration[7.0]
  def change
    create_table :user_answer_histories, id: :uuid do |t|
      t.uuid :user_id, null: false
      t.uuid :questionnaire_id, null: false
      t.uuid :question_id, null: false
      t.uuid :selected_option_id, null: false
      t.boolean :is_correct
      t.timestamp :answered_at, null: false
      t.text :question_snapshot
      t.timestamps
      t.timestamp :deleted_at
    end

    add_foreign_key :user_answer_histories, :users, column: :user_id
    add_foreign_key :user_answer_histories, :questionnaires
    add_foreign_key :user_answer_histories, :questions
    add_foreign_key :user_answer_histories, :question_options, column: :selected_option_id
  end
end
