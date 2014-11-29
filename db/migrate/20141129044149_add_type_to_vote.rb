class AddTypeToVote < ActiveRecord::Migration
  def change
    add_column :vote_votes, :type, :string
  end
end
