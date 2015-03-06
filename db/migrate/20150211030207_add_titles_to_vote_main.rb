class AddTitlesToVoteMain < ActiveRecord::Migration
  def change
    add_column :vote_vote_mains, :titles, :json
  end
end
