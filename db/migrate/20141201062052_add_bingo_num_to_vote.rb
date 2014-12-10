class AddBingoNumToVote < ActiveRecord::Migration
  def change
    add_column :vote_votes, :bingo_num, :integer
  end
end
