class AddIsManageToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :is_manage, :boolean , default: false
  end
end
