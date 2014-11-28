class ModifyRelationVoterIdToInsId < ActiveRecord::Migration
  def change
    add_column :vote_vote_relations, :ins_id, :integer
    remove_column :vote_vote_relations, :voter_id
  end
end
