class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments, id: :uuid do |t|
      t.references :user, type: :uuid, null: false, foreign_key: true
      t.references :commentable, polymorphic: true, null: false, type: :uuid
      t.boolean :deleted, default: false
      t.uuid :parent_id
      t.text :body

      t.timestamps
    end
  end
end
