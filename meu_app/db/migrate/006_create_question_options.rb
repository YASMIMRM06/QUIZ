class CreateQuestionOptions < ActiveRecord::Migration[7.0]
  def change
    create_table :question_options, id: :uuid do |t|
      t.uuid :question_id, null: false
      t.string :title, null: false
      t.boolean :is_correct, default: false
      t.timestamps
      t.timestamp :deleted_at
    end

    add_foreign_key :question_options, :questions
  end
end