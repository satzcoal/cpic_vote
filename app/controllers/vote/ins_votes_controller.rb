# encoding: utf-8
class Vote::InsVotesController < ApplicationController

  def show
    voter_id = session[:voter_id]
    vote_id = params[:vote_id]
    @ins_vote = Vote::InsVote.find_or_create_by(:vote_id => vote_id, :user_id => voter_id)
    @items = eval("#{vote.vote_item}.all") - @ins_vote.results
  end

  def vote
    ins_id = params[:ins_id]
    item_id = params[:item_id]
    ins = Vote::InsVote.find(ins_id)
    if ins.is_allow_more?
      redirect_to :back, notice: '对不起，您的投票名额已满！'
    else
      Vote::Gonghui.vote_user(voter_id, user_id)
      redirect_to :back, notice: '投票成功！'
    end
  end

  def unvote
    voter_id = session[:user_id]
    user_id = params[:user_id]
    #Vote::GonghuiUserRelation.where(:voter_id => voter_id, :user_id => user_id).each { |r| r.destroy }
    redirect_to :back, notice: '取消成功！'
  end

  def submit
    gonghui_id = params[:gonghui_id]
    @gonghui = Vote::Gonghui.find(gonghui_id)
    if @gonghui.res_list.count == 2
      @gonghui.status = 1
      @gonghui.save
      redirect_to :back, notice: '提交成功！'
    else
      redirect_to :back, notice: "您只选择了#{@gonghui.res_list.count.to_s}位候选人，请继续选择！"
    end
  end

  def reedit
    gonghui_id = params[:gonghui_id]
    gonghui = Vote::Gonghui.find(gonghui_id)
    gonghui.status = 0
    gonghui.save
    redirect_to :back
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_vote_ins
    @vote_ins = Vote::VoteIns.find(params[:id])
  end
end