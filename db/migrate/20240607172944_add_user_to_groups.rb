class AddUserToGroups < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :group_id, :integer
  end
end
