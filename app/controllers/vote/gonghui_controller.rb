# encoding: utf-8
class Vote::GonghuiController < ApplicationController
  @@vote = Vote::Vote.find_by_en_name('Gonghui')

  before_action :set_ins

  def show
    @users = Origin::User.all - @ins.results
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

  private
  def set_ins
    voter_id = session[:user_id]
    @ins = Vote::InsVote.find_or_create_by(:user_id => voter_id, :vote_id => @@vote.id)
  end
end