class Vote::VoteItem < ActiveRecord::Base
  self.per_page = 20
  belongs_to :vote, :class_name => 'Vote::VoteMain', foreign_key: :vote_id
  has_many :relations, :class_name => 'Vote::VoteRelation', foreign_key: :item_id
  has_many :ins_votes, :class_name => 'Vote::InsVote', :through => :relations, :source => :ins_vote
end
