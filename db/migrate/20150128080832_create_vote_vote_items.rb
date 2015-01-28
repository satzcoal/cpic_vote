class CreateVoteVoteItems < ActiveRecord::Migration
  def change
    create_table :vote_vote_items do |t|
      t.json :content

      t.timestamps
    end
  end
end
