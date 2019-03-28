class ChangeNotificationColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :notifications, :type, :typeOfMessage
  end
end
