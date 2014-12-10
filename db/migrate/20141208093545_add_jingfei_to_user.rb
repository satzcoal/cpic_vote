class AddJingfeiToUser < ActiveRecord::Migration
  def change
    add_column :origin_users, :score3, :integer, default: 0
    add_column :origin_users, :vote_res3, :integer, default: 0
  end
end
