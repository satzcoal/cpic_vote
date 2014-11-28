class Vote::InsVote < ActiveRecord::Base

  after_create :gen_relation_class

  belongs_to :voter, :class_name => 'Origin::User', foreign_key: :user_id
  belongs_to :vote, :class_name => 'Vote::Vote', foreign_key: :vote_id

  has_many :relations, :class_name => 'Vote::VoteRelation', foreign_key: :ins_id
  #has_many :results, :class_name => 'Origin::User', :through => :vote_gonghui_user_relations, :source => :origin_user

  def vote_item(item_id)
    self.transaction do
      self.results.build(:item_id => item_id)
    end
  end

  def is_validate?(offset=0)
    return self.results.count + offset <= :voter.max_num && self.results.count + offset >= :voter.min_num
  end

  def is_allow_more?
    return is_validate?(1)
  end

  def respond_to?(method, pri=false)
    (method.to_s =~ /^results$/) || super
  end

  def method_missing(sym, *args)
    if sym.to_s =~ /^results$/
      singleton_class = class << self;
        self
      end
      puts vote.vote_item
      singleton_class.has_many :results, :class_name => vote.vote_item, :through => :relations, :source => :item
      self.results
    else
      super
    end
  end

  private
  def gen_relation_class
    base_namespace = vote.vote_item.split('::')[0..-2].join('::')
    base_namespace = 'Object' if base_namespace == ''
    base_name = vote.vote_item.split('::')[-1] + 'Relation'
    unless eval("defined?(#{vote.vote_item}Relation)") && eval("#{vote.vote_item}Relation.is_a?(Class)")
      eval("#{base_namespace}.const_set(base_name, Class.new(Vote::VoteRelation))")
      self.has_many(:relations, :class_name => base_name, foreign_key: :ins_id)

      options[:create] = true if options[:create] == nil
      options[:destroy] = true if options[:destroy] == nil
      options[:update] = true if options[:update] == nil

      options.each do |key, value|
        if value
          eval("self.around_#{key} :around_#{key}_his")
        end
      end

      self.send(:include, InstanceMethods)
      self.send :class_variable_set, '@@tmp_his_attr', name
      self.cattr_accessor :tmp_his_attr
    end
  end
end
