class CreateUserOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :user_orders do |t|
      t.text :status

      t.timestamps
    end
  end
end
