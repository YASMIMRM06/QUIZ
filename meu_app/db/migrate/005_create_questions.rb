class CreateQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :questions do |t|
      t.references :questionnaire, null: false, foreign_key: true
      t.string :enunciation, null: false
      t.timestamps
      t.timestamp :deleted_at
    end
  end
end
