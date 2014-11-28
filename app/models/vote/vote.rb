class Vote::Vote < ActiveRecord::Base
  has_many :ins_votes, :class_name => 'Vote::InsVote', foreign_key: :vote_id

  after_create :gen_tmp_class

  private
  def gen_tmp_class
    gen_tmp_class_with_word(en_name, 'Vote::InsVote')
    gen_tmp_class_with_word(en_name, 'Vote::VoteRelation')
    self.has_many(:relations, :class_name => base_name, foreign_key: :ins_id)
  end

  def gen_tmp_class_with_word(word, base_class)
  base_namespace = vote_item.split('::')[0..-2].join('::')
  base_namespace = 'Object' if base_namespace == ''
  base_name = vote_item.split('::')[-1] + word
  unless eval("defined?(#{vote_item}#{word})") && eval("#{vote_item}#{word}.is_a?(Class)")
    eval("#{base_namespace}.const_set(base_name, Class.new(#{base_class}))")
  end
end
