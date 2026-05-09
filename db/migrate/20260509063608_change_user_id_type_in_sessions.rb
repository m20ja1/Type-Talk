class ChangeUserIdTypeInSessions < ActiveRecord::Migration[8.1]
  def change
    remove_foreign_key :sessions, :users
    change_column :sessions, :user_id, :bigint, null: false
    add_foreign_key :sessions, :users
  end
end
