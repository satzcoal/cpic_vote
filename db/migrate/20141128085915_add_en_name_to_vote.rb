class AddEnNameToVote < ActiveRecord::Migration
  def change
    add_column :vote_votes, :en_name, :string
  end
end
