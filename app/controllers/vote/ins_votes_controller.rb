# encoding: utf-8
class Vote::InsVotesController < ApplicationController

  def show
    voter_id = session[:voter_id]
    vote_id = params[:vote_id]
    @ins_vote = Vote::InsVote.find_or_create_by(:vote_id => vote_id, :user_id => voter_id)

    case @ins_vote.vote.status
      when Vote::VoteMain::STATUS_PROCESS then
        render :vote_page #@ins_vote.vote.template
      else
        render :info_page, :locals => {:info_str => 'asdf'}
    end
  end

  def select_item
    res = Vote::InsVote.select_item(params[:ins_id], params[:item_id])
    if res.present?
      redirect_to :back, notice: res
    else
      redirect_to :back, notice: '投票成功！'
    end
  end

  def cancel_item
    res = Vote::InsVote.cancel_item(params[:ins_id], params[:item_id])
    if res.present?
      redirect_to :back, notice: res
    else
      redirect_to :back, notice: '取消成功！'
    end
  end

  def submit
    res = Vote::InsVote.submit(params[:ins_id])
    if res.present?
      redirect_to :back, notice: res
    else
      redirect_to :back, notice: '提交成功！'
    end
  end

  def edit
    Vote::InsVote.edit(params[:ins_id])
    redirect_to :back, notice: '返回修改成功！'
  end
end