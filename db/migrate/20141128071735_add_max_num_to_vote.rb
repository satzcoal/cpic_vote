class AddMaxNumToVote < ActiveRecord::Migration
  def change
    add_column :vote_votes, :max_num, :integer
    add_column :vote_votes, :min_num, :integer
    add_column :vote_votes, :vote_item, :string
  end
end
