class AddTitlesToVoteMain < ActiveRecord::Migration
  def change
    add_column :vote_vote_mains, :titles, :string
  end
end
