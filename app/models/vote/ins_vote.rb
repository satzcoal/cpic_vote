class Vote::InsVote < ActiveRecord::Base

  belongs_to :voter, :class_name => 'Origin::User', foreign_key: :user_id
  belongs_to :vote, :class_name => 'Vote::Vote', foreign_key: :vote_id

  def vote_item(item_id)
    self.transaction do
      self.relations.build(:item_id => item_id).save
    end
  end

  def is_validate?(offset=0)
    return self.results.count + offset <= vote.max_num && self.results.count + offset >= vote.min_num
  end

  def max_validate?(offset=0)
    self.results.count + offset <= vote.max_num
  end

  def is_allow_more?
    return max_validate?(1)
  end
end
