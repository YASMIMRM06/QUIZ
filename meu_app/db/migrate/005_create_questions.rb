class CreateQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :questions, id: :uuid do |t|
      t.uuid :questionnaire_id, null: false
      t.string :enunciation, null: false
      t.timestamps
      t.timestamp :deleted_at
    end

    add_foreign_key :questions, :questionnaires
  end
end