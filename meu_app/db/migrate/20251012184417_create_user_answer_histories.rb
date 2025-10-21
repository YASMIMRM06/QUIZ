class CreateUserAnswerHistories < ActiveRecord::Migration[7.1]
  def change
    create_table :user_answer_histories do |t|
      t.boolean :is_correct
      t.timestamp :answered_at
      t.references :user, null: false, foreign_key: true
      t.references :questionnaire, null: false, foreign_key: true
      t.references :question, null: false, foreign_key: true
      t.references :question_option, null: false, foreign_key: true

      t.timestamps
    end
  end
end
