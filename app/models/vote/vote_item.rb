class Vote::VoteItem < ActiveRecord::Base
  belongs_to :vote, :class_name => 'Vote::VoteMain', foreign_key: :vote_id
  has_many :relations, :class_name => 'Vote::VoteRelation', foreign_key: :item_id
end
