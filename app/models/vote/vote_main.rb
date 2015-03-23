# encoding: utf-8
require 'file_tools'
class Vote::VoteMain < ActiveRecord::Base

  has_many :ins_votes, :class_name => 'Vote::InsVote', foreign_key: :vote_id
  has_many :items, :class_name => 'Vote::VoteItem', foreign_key: :vote_id
  has_many :results, :class_name => 'Vote::VoteRes', foreign_key: :vote_id

  #before_save 'Vote::VoteMain.gen_tmp_class vote_item, en_name'

  #define_model_callbacks :prepare, :process, :finish, :publish

  STATUSES = [STATUS_NEW = 0, STATUS_ENABLE = 1, STATUS_PROCESS = 2, STATUS_FINISH = 3,
              STATUS_FINISH_NO_CAL = 13, STATUS_PUBLISH = 4, STATUS_CLOSE = 5, STATUS_DISABLE = 100..199]

  STATUS_DICT = {
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
      STATUS_DICT[code]
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
    titles_tmp = {}
    header.each_with_index do |h, index|
      titles_tmp[index] = {name: h, data_col: index}
    end
    self.titles = titles_tmp

    ((has_title ? 2 : 1)..spreadsheet.last_row).each do |i, index|
      #row = Hash[[header, spreadsheet.row(i)].transpose]
      item = self.items.build
      content_tmp = {}
      spreadsheet.row(i).each_with_index do |c, index|
        content_tmp[index] = c
      end
      item.content = content_tmp

      #item.attributes = row.to_hash.slice(*accessible_attributes)
    end
  end

  def enable
    self.transaction do
      if self.status == STATUS_NEW
        self.status = STATUS_ENABLE
      elsif self.status > 99
        self.status -= 100
      else
        raise '启用投票前投票状态必须为【未启用】或【已禁用】'
      end
      self.save
    end
  end

  def process
    self.transaction do
      if self.status == STATUS_ENABLE
        self.status = STATUS_PROCESS
        self.save
      else
        raise '开始投票前投票状态必须为【已启用】'
      end
    end
  end

  def finish
    self.transaction do
      if self.status == STATUS_PROCESS
        if WorkOutVoteRes.call(self)
          self.status = STATUS_FINISH
          self.save
        else
          self.status = STATUS_FINISH_NO_CAL
          self.save
        end
      else
        raise '结束投票前投票状态必须为【正在投票】'
      end
    end
  end

  def work_out
    self.transaction do
      if WorkOutVoteRes.call(self)
        self.save
      end
    end
  end

  def publish
    self.transaction do
      if self.status == STATUS_FINISH
        self.status = STATUS_PUBLISH
        self.save
      else
        raise '公布结果前投票状态必须为【已截止】'
      end
    end
  end

  def close
    self.transaction do
      if self.status == STATUS_PUBLISH || self.status == STATUS_FINISH
        self.status = STATUS_CLOSE
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

  def reset
    self.transaction do
      self.status = STATUS_NEW
      self.ins_votes.destroy_all
      self.results.destroy_all
      self.save
    end
  end

  def swap_titles(a_index, b_index)
    self.transaction do
      self.titles[a_index.to_s], self.titles[b_index.to_s] = self.titles[b_index.to_s], self.titles[a_index.to_s]
      self.titles_will_change!
      self.save
    end
  end
end
