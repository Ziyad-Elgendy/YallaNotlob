class AddUserIdInOrderItem < ActiveRecord::Migration[5.2]
  def change
    add_reference :order_items, :user, foreign_key: true
  end
end
