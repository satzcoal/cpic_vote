# encoding: utf-8
class Vote::Vote < ActiveRecord::Base

  has_many :ins_votes, :class_name => 'Vote::InsVote', foreign_key: :vote_id
  #before_save 'Vote::Vote.gen_tmp_class vote_item, en_name'

  define_model_callbacks :prepare, :process, :finish, :publish

  STATUS = {
      0 => '创建阶段',
      1 => '准备阶段',
      2 => '投票阶段',
      3 => '截止阶段',
      4 => '公布阶段'
  }

  def prepare

  end

  def process

  end

  def finish

  end

  def publish

  end
end
