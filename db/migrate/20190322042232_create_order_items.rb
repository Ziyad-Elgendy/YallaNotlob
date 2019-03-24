class CreateOrderItems < ActiveRecord::Migration[5.2]
  def change
    create_table :order_items do |t|
      t.text :name
      t.integer :amount
      t.float :price
      t.text :comment

      t.timestamps
    end
  end
end
