class AddOrderToNotification < ActiveRecord::Migration[5.2]
  def change
    add_reference :notifications, :order, foreign_key: true
  end
end
