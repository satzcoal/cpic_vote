class CreateVoteInsVotes < ActiveRecord::Migration
  def change
    create_table :vote_ins_votes do |t|
      t.integer :user_id
      t.integer :status, default: 0
      t.integer :vote_id
      t.string :type

      t.timestamps
    end
  end
end
