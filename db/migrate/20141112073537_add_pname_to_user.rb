class AddPnameToUser < ActiveRecord::Migration
  def up
    add_column :origin_users, :pname, :string
  end

  def down
    remove_column :origin_users, :pname
  end
end
