class AddRoleIdtouser < ActiveRecord::Migration
  def up
    add_column :origin_users, :role_id, :integer
  end

  def down
    remove_column :origin_users, :role_id
  end
end
