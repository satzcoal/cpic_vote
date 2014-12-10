# encoding: utf-8
class Vote::JingfeiController < ApplicationController
  @@vote = Vote::Vote.find_by_en_name('Jingfei')

  before_action :set_ins

  def show
    @vote = @@vote
    if @@vote.status == 1
      @users = Origin::User.where(:name => ['liusha', 'xiaoliang', 'yanjiafu']) - @ins.results
    elsif @@vote.status == 2
      redirect_to :action => :score
    elsif @@vote.status == 0
      render :action => :ready
    end
  end

  def vote_user
    item_id = params[:item_id]
    if @ins.is_allow_more?
      @ins.vote_item(item_id)
      redirect_to :back, notice: '选择成功！'
    else
      redirect_to :back, notice: '对不起，您的选择名额已满！'
    end
  end

  def unvote_user
    item_id = params[:item_id]
    @ins.relations.where(:item_id => item_id).each { |i| i.destroy }
    redirect_to :back, notice: '取消成功！'
  end

  def submit
    if @ins.is_validate?
      @ins.status = 1
      @ins.save
      redirect_to :back, notice: '提交成功！'
    else
      redirect_to :back, notice: "您只选择了#{@ins.results.count.to_s}位候选人，请继续选择！"
    end
  end

  def reedit
    @ins.status = 0
    @ins.save
    redirect_to :back
  end

  def start
    Origin::User.all.each do |user|
      user.score3 = 0
      user.vote_res3 = 0
      user.save
    end
    @@vote.status = 1
    @@vote.save
    redirect_to :back, notice: "投票#{@@vote.name}已成功开始！"
  end

  def stop
    @@vote.status = 2
    @@vote.save
    @@vote.ins_votes.each do |ins|
      ins.results.each do |item|
        item.score3 += 1
        item.save
      end
      ins.status = 1
      ins.save
    end

    Origin::User.order(:score3 => :desc).limit(@@vote.bingo_num).each do |u|
      u.vote_res3 = 1
      u.save
    end

    redirect_to :back, notice: "投票#{@@vote.name}已成功截止！"
  end

  def score
    @vote = @@vote
    @bingo_users = Origin::User.where(:name => ['liusha', 'xiaoliang', 'yanjiafu']).order(:score3 => :desc)
    @users = []
  end

  def renew
    @@vote.status = 0
    @@vote.save
    redirect_to :back, notice: "投票#{@@vote.name}已重置！"
  end

  private
  def set_ins
    voter_id = session[:user_id]
    @ins = Vote::InsVote.where(:user_id => voter_id, :vote_id => @@vote.id).first
    unless @ins
      @ins = @@vote.ins_votes.build(:user_id => voter_id)
      @ins.save
    end
  end
end