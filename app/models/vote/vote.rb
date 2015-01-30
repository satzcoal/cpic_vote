# encoding: utf-8
class Vote::Vote < ActiveRecord::Base

  has_many :ins_votes, :class_name => 'Vote::InsVote', foreign_key: :vote_id
  has_many :vote_items, :class_name => 'Vote::VoteItem', foreign_key: :vote_id

  #before_save 'Vote::Vote.gen_tmp_class vote_item, en_name'

  define_model_callbacks :prepare, :process, :finish, :publish

  STATUS = {
      0 => '未启用',
      1 => '已启用',
      2 => '正在投票',
      3 => '已截止',
      4 => '正在公布',
      5 => '已归档'
  }

  def self.get_status(code)
    if code.to_i > 100
      '已禁用'
    else
      STATUS[code]
    end
  end

  def prepare

  end

  def process

  end

  def finish

  end

  def publish

  end
end
