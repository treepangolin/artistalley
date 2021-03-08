class CreateInvites < ActiveRecord::Migration[6.1]
  def change
    create_table :invites do |t|
      t.boolean :redeemed
      t.string :code
      t.references :user, null: true, foreign_key: true

      t.timestamps
    end
  end
end
