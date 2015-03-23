# encoding: utf-8
class Vote::InsVote < ActiveRecord::Base

  belongs_to :voter, :class_name => 'Origin::User', foreign_key: :user_id
  belongs_to :vote, :class_name => 'Vote::VoteMain', foreign_key: :vote_id

  has_many :relations, :class_name => 'Vote::VoteRelation', foreign_key: :ins_id
  has_many :results, :class_name => 'Vote::VoteItem', :through => :relations, :source => :item

  def self.select_item(ins_id, item_id)
    ins = find(ins_id)
    ins.transaction do
      if ins.is_allow_more?
        ins.vote_item item_id
        ins.save
      else
        return '对不起，您的投票名额已满！'
      end
    end
    return nil
  end

  def self.cancel_item(ins_id, item_id)
    Vote::VoteRelation.where(:ins_id => ins_id, :item_id => item_id).try(:first).try(:destroy)
    return nil
  end

  def self.submit(ins_id)
    ins = find(ins_id)
    ins.transaction do
      if ins.is_validate?
        ins.status = 1
        ins.save
      else
        return '您选择的数量不足，请继续选择！'
      end
    end
    return nil
  end

  def self.edit(ins_id)
    ins = find(ins_id)
    ins.status = 0
    ins.save
    return nil
  end

  def vote_item(item_id)
    self.relations.build(:item_id => item_id)
  end

  def is_validate?(offset=0)
    return self.results.count + offset <= vote.max_num && self.results.count + offset >= vote.min_num
  end

  def max_validate?(offset=0)
    self.results.count + offset <= vote.max_num
  end

  def is_allow_more?
    return max_validate?(1) && status == 0
  end
end
