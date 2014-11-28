class Vote::Gonghui < ActiveRecord::Base
  belongs_to :voter, :class_name => 'Origin::User', foreign_key: :user_id
  belongs_to :vote, :class_name => 'Vote::Vote', foreign_key: :vote_id
  has_many :vote_gonghui_user_relations, :class_name => 'Vote::GonghuiUserRelation', foreign_key: :voter_id
  has_many :res_list, :class_name => 'Origin::User', :through => :vote_gonghui_user_relations, :source => :origin_user
   def self.vote_user(voter_id, user_id)
    self.transaction do
      Vote::GonghuiUserRelation.find_or_create_by(:voter_id => voter_id, :user_id => user_id)
    end
  end

  def self.is_full?(voter_id)
    return self.find_or_create_by(:user_id => voter_id).res_list.count >= 2
  end
end