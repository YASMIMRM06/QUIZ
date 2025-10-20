class AddUserToQuestionnaires < ActiveRecord::Migration[7.1]
  def change
    add_reference :questionnaires, :user, type: :uuid, null: false, foreign_key: true
  end
end
