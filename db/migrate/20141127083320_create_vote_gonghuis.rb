class CreateVoteGonghuis < ActiveRecord::Migration
  def change
    create_table :vote_gonghuis do |t|
      t.integer :user_id

      t.timestamps
    end
  end
end
