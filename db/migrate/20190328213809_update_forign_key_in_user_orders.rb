class UpdateForignKeyInUserOrders < ActiveRecord::Migration[5.2]
  def change
    remove_foreign_key :user_orders, :orders 
    add_foreign_key :user_orders, :orders,  on_delete: :cascade
  end
end
