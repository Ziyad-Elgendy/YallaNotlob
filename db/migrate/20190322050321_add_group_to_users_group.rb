class AddGroupToUsersGroup < ActiveRecord::Migration[5.2]
  def change
    add_reference :users_groups, :group, foreign_key: true
  end
end
