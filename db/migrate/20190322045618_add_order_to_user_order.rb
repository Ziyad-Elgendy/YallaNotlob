class AddOrderToUserOrder < ActiveRecord::Migration[5.2]
  def change
    add_reference :user_orders, :order, foreign_key: true
    add_reference :user_orders, :user, foreign_key: true

  end
end
