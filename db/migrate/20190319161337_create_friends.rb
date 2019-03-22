class CreateFriends < ActiveRecord::Migration[5.2]
  def change
    create_table :friends do |t|
      t.integer :user_1
      t.integer :user_2
      # t.references :user, foreign_key: true
      # t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
