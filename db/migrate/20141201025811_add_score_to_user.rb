class AddScoreToUser < ActiveRecord::Migration
  def change
    add_column :origin_users, :score, :integer, default: 0
    add_column :origin_users, :vote_res, :integer, default: 0
  end
end
