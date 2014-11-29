class ModifyVoteStatus < ActiveRecord::Migration
  def change
    change_column_default :vote_votes, :status, 0
  end
end
