class AddSerialNumberActiveFlagToOriginSidebarItems < ActiveRecord::Migration
  def up
    add_column :origin_sidebar_items, :serial_number, :integer
    add_column :origin_sidebar_items, :active_flag, :boolean
  end

  def down
    remove_column :origin_sidebar_items, :serial_number
    remove_column :origin_sidebar_items, :active_flag
  end
end
