class AddDeptBranchToUser < ActiveRecord::Migration
  def change
    add_column :origin_users, :dept, :string
    add_column :origin_users, :branch, :string
  end
end
