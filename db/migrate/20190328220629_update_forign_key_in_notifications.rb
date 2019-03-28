class UpdateForignKeyInNotifications < ActiveRecord::Migration[5.2]
  def change
    remove_foreign_key :notifications, :orders
    add_foreign_key :notifications, :orders,  on_delete: :cascade
  end
end
