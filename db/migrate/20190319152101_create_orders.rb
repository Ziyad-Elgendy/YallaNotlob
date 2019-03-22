class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.text :restaurant
      t.text :type
      t.text :status
      t.blob :menu_img
      t.references :user, foreign_key: false

      t.timestamps
    end
  end
end
