class CreateOriginSidebarItems < ActiveRecord::Migration
  def change
    create_table :origin_sidebar_items do |t|
      t.string :name
      t.string :url
      t.integer :site_id
      t.integer :parent_id
      t.integer :serial_number
      t.boolean :active_flag

      t.timestamps
    end
  end
end
