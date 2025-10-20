class CreateQuestionOptions < ActiveRecord::Migration[7.0]
  def change
    create_table :question_options do |t|
      t.references :question, null: false, foreign_key: true
      t.string :title, null: false
      t.boolean :is_correct, default: false
      t.timestamps
      t.timestamp :deleted_at
    end
  end
end
