class CreateUserAnswerHistories < ActiveRecord::Migration[7.0]
  def change
    create_table :user_answer_histories do |t|
      t.references :user, null: false, foreign_key: true
      t.references :questionnaire, null: false, foreign_key: true
      t.references :question, null: false, foreign_key: true
      t.references :selected_option, null: false, foreign_key: { to_table: :question_options }
      t.boolean :is_correct
      t.timestamp :answered_at, null: false
      t.text :question_snapshot
      t.timestamps
      t.timestamp :deleted_at
    end
  end
end
