class CreateVoteVotes < ActiveRecord::Migration
  def change
    create_table :vote_votes do |t|
      t.string :name
      t.datetime :start_time
      t.datetime :stop_time
      t.string :url

      t.timestamps
    end
  end
end
