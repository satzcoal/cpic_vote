class Vote::GonghuiUserRelation < ActiveRecord::Base
  belongs_to :vote_gonghui, :class_name => 'Vote::Gonghui', foreign_key: :voter_id
  belongs_to :origin_user, :class_name => 'Origin::User', foreign_key: :user_id
end
