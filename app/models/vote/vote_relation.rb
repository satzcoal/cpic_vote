class Vote::VoteRelation < ActiveRecord::Base
  belongs_to :ins_vote, :class_name => 'Vote::InsVote', foreign_key: :ins_id
  belongs_to :item, :class_name => 'Vote::VoteItem', foreign_key: :item_id
end
