class AddStatusToVoteGonghui < ActiveRecord::Migration
  def change
    add_column :vote_gonghuis, :status, :integer, :default => 0
  end
end
