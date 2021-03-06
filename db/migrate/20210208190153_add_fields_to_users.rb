class AddFieldsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :username, :string
    add_index :users, :username, unique: true
    add_column :users, :role, :integer
    add_column :users, :bio, :text
    add_column :users, :location, :string
    add_column :users, :pronouns, :string
    add_column :users, :avatar_data, :text
  end
end
