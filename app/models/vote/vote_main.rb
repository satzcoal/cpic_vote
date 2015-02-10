# encoding: utf-8
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

  def self.import(file)
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      product = find_by_id(row["id"]) || new
      product.attributes = row.to_hash.slice(*accessible_attributes)
      product.save!
    end
  end

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
      when ".csv" then Roo::CSV.new(file.path, nil)
      when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
      when ".xlsx" then Roo::Excelx.new(file.path, nil, :ignore)
      else raise "Unknown file type: #{file.original_filename}"
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
