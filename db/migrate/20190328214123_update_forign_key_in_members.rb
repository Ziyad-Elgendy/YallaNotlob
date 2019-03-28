class UpdateForignKeyInMembers < ActiveRecord::Migration[5.2]
  def change
    remove_foreign_key :members, :groups
    add_foreign_key :members, :groups,  on_delete: :cascade

  end
end
