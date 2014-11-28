class CreateOriginRoleItemShips < ActiveRecord::Migration
  def change
    create_table :origin_role_item_ships do |t|
      t.integer :role_id
      t.integer :sidebar_item_id

      t.timestamps
    end
  end
end
