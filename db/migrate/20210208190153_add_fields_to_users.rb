class AddFieldsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :username, :string
    add_index :users, :username, unique: true
    add_column :users, :role, :integer
    add_column :users, :bio, :text
    add_column :users, :location, :string
  end
end
