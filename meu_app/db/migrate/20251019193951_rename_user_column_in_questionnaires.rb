class RenameUserColumnInQuestionnaires < ActiveRecord::Migration[7.1]
  def change
    rename_column :questionnaires, :user, :user_id
  end
end
