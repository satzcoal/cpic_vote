# encoding: utf-8
require 'file_tools'
class Vote::VoteMain < ActiveRecord::Base

  has_many :ins_votes, :class_name => 'Vote::InsVote', foreign_key: :vote_id
  has_many :vote_items, :class_name => 'Vote::VoteItem', foreign_key: :vote_id

  #before_save 'Vote::VoteMain.gen_tmp_class vote_item, en_name'

  #define_model_callbacks :prepare, :process, :finish, :publish

  STATUS = {
      0 => '未启用',
      1 => '已启用',
      2 => '正在投票',
      3 => '已截止',
      13 => '已截止（未计算结果）',
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

  def import(file, has_title)
    spreadsheet = FileTools.open_spreadsheet(file)
    if has_title
      header = spreadsheet.row(1)
    else
      header = []
      spreadsheet.last_column.times { |x| header[x] = "tmp#{x}" }
    end

    ((has_title ? 2 : 1)..spreadsheet.last_row).each do |i|
      #row = Hash[[header, spreadsheet.row(i)].transpose]
      item = self.vote_items.build
      self.titles = header.join('|||')
      item.content = spreadsheet.row(i).join('|||')

      #item.attributes = row.to_hash.slice(*accessible_attributes)
    end
  end

  def enable
    self.transaction do
      case self.status
        when 0 then
          self.status = 1
        when 1..99 then
        else
          self.status -= 100
      end
      self.save
    end
  end

  def process
    self.transaction do
      if self.status == 1
        self.status = 2
        self.save
      else
        raise '开始投票前投票状态必须为【已启用】'
      end
    end
  end

  def finish
    self.transaction do
      if self.status == 2
        if WorkOutVoteRes(self)
          self.status = 3
          self.save
        else
          self.status = 13
          self.save
        end
      else
        raise '结束投票前投票状态必须为【正在投票】'
      end
    end
  end

  def work_out
    self.transaction do
      if self.status == 13
        if WorkOutVoteRes(self)
          self.status = 3
          self.save
        else
          self.status = 13
          self.save
        end
      end
    end
  end

  def publish
    self.transaction do
      if self.status == 3
        self.status = 4
        self.save
      else
        raise '公布结果前投票状态必须为【已截止】'
      end
    end
  end

  def close
    self.transaction do
      if self.status == 4 || self.status == 3
        self.status = 5
        self.save
      else
        raise '公布结果前投票状态必须为【已截止】或【正在公布】'
      end
    end
  end

  def disable
    self.transaction do
      self.status += 100 unless self.status > 99
      self.save
    end
  end
end
