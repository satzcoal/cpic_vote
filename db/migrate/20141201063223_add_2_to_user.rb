class Add2ToUser < ActiveRecord::Migration
  def change
    add_column :origin_users, :score2, :integer, default: 0
    add_column :origin_users, :vote_res2, :integer, default: 0
  end
end
