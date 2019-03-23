class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.text :type
      t.text :restaurant
      t.binary :img
      t.text :status

      t.timestamps
    end
  end
end
