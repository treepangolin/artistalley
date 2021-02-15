class AddDeletedToComment < ActiveRecord::Migration[6.1]
  def change
    add_column :comments, :deleted, :boolean, default: false
  end
end
