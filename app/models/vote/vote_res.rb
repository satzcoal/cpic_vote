class Vote::VoteRes < ActiveRecord::Base
  belongs_to :vote, :class_name => 'Vote::VoteMain', foreign_key: :vote_id
  belongs_to :item, :class_name => 'Vote::VoteItem', foreign_key: :item_id
end
