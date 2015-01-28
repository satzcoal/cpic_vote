class CreateVoteVoteRelations < ActiveRecord::Migration
  def change
    create_table :vote_vote_relations do |t|
      t.integer :ins_id
      t.integer :item_id
      t.string :type

      t.timestamps
    end
  end
end
