class AddOrderToNotification < ActiveRecord::Migration[5.2]
  def change
    add_reference :notifications, :order, foreign_key: true
    add_reference :notifications, :user, foreign_key: true

  end
end
