class CreateVoteVoteMains < ActiveRecord::Migration
  def change
    create_table :vote_vote_mains do |t|
      t.string :name
      t.datetime :start_time
      t.datetime :stop_time
      t.string :url
      t.integer :status, :default => 0
      t.integer :max_num
      t.integer :min_num
      t.string :vote_item
      t.string :en_name
      t.string :type
      t.integer :bingo_num

      t.timestamps
    end
  end
end
