class CreateOriginUsers < ActiveRecord::Migration
  def change
    create_table :origin_users do |t|
      t.string :name
      t.string :hashed_password
      t.string :salt
      t.integer :role_id
      t.string :pname

      t.timestamps
    end
  end
end
