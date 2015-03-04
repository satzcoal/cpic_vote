class AddTemplateToVoteMain < ActiveRecord::Migration
  def change
    add_column :vote_vote_mains, :template, :string
  end
end
