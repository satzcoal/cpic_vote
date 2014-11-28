class CreateOriginRoles < ActiveRecord::Migration
  def change
    create_table :origin_roles do |t|
      t.string :name
      t.boolean :adminFlag

      t.timestamps
    end
  end
end
