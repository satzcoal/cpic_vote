class CreateVoteGonghuiUserRelations < ActiveRecord::Migration
  def change
    create_table :vote_gonghui_user_relations do |t|
      t.integer :voter_id
      t.integer :user_id

      t.timestamps
    end
  end
end
