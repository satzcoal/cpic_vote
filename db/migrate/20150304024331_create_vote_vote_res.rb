class CreateVoteVoteRes < ActiveRecord::Migration
  def change
    create_table :vote_vote_res do |t|
      t.integer :vote_id
      t.integer :item_id
      t.integer :index
      t.json :res_info

      t.timestamps
    end
  end
end
