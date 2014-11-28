class AddStatusVoteIdToVote < ActiveRecord::Migration
  def change
    add_column :vote_votes, :status, :integer
    add_column :vote_gonghuis, :vote_id, :integer
  end
end
