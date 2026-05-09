class AddColumnsToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :name, :string
    add_column :users, :mbti_type, :string
    add_column :users, :introduction, :text
  end
end
