# encoding: utf-8
class Vote::Vote < ActiveRecord::Base

  define_model_callbacks :prepare, :process, :finish, :publish

  STATUS = {
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

  has_many :ins_votes, :class_name => 'Vote::InsVote', foreign_key: :vote_id
  before_save :gen_type, :gen_tmp_class

  private
  def gen_type
    self.type = vote_item + en_name + 'Vote'
  end

  def gen_tmp_class_with_word(word, base_class)
    base_namespace = vote_item.split('::')[0..-2].join('::')
    base_namespace = 'Object' if base_namespace == ''
    base_name = vote_item.split('::')[-1] + word
    unless eval("defined?(#{vote_item}#{word})") && eval("#{vote_item}#{word}.is_a?(Class)")
      eval("#{base_namespace}.const_set(base_name, Class.new(#{base_class}))")
      eval("#{vote_item}#{word}")
    else
      nil
    end
  end

  def self.gen_all_tmp_class
    ActiveRecord::Base.connection.execute('SELECT * FROM vote_votes').each do |v|
      gen_tmp_class(v['vote_item'], v['en_name'])
    end
  end

  def self.gen_tmp_class_with_word(word, base_class, vote_item)
    base_namespace = vote_item.split('::')[0..-2].join('::')
    base_namespace = 'Object' if base_namespace == ''
    base_name = vote_item.split('::')[-1] + word
    unless eval("defined?(#{vote_item}#{word})") && eval("#{vote_item}#{word}.is_a?(Class)")
      eval("#{base_namespace}.const_set(base_name, Class.new(#{base_class}))")
      eval("#{vote_item}#{word}")
    else
      nil
    end
  end

  def gen_tmp_class
    vote_clz = gen_tmp_class_with_word(self.en_name + 'Vote', 'Vote::Vote')
    ins_clz = gen_tmp_class_with_word(self.en_name + 'Ins', 'Vote::InsVote')
    rel_clz = gen_tmp_class_with_word(self.en_name + 'Rel', 'Vote::VoteRelation')

    if vote_clz
      vote_clz.has_many :ins_votes, :class_name => ins_clz.to_s, foreign_key: :vote_id

      rel_clz.belongs_to :ins_vote, :class_name => ins_clz.to_s, foreign_key: :ins_id
      rel_clz.belongs_to :item, :class_name => vote_item, foreign_key: :item_id

      ins_clz.has_many :relations, :class_name => rel_clz.to_s, foreign_key: :ins_id
      ins_clz.has_many :results, :class_name => vote_item, :through => :relations, :source => :item
    end
  end

  def self.gen_tmp_class(vote_item, en_name)

    vote_clz = gen_tmp_class_with_word(en_name + 'Vote', 'Vote::Vote', vote_item)
    ins_clz = gen_tmp_class_with_word(en_name + 'Ins', 'Vote::InsVote', vote_item)
    rel_clz = gen_tmp_class_with_word(en_name + 'Rel', 'Vote::VoteRelation', vote_item)

    if vote_clz
      vote_clz.has_many :ins_votes, :class_name => ins_clz.to_s, foreign_key: :vote_id

      rel_clz.belongs_to :ins_vote, :class_name => ins_clz.to_s, foreign_key: :ins_id
      rel_clz.belongs_to :item, :class_name => vote_item, foreign_key: :item_id

      ins_clz.has_many :relations, :class_name => rel_clz.to_s, foreign_key: :ins_id
      ins_clz.has_many :results, :class_name => vote_item, :through => :relations, :source => :item
    end
  end

  gen_all_tmp_class
end
