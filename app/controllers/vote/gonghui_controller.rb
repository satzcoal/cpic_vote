# encoding: utf-8
class Vote::GonghuiController < ApplicationController
  def show
    voter_id = session[:user_id]
    @gonghui = Vote::Gonghui.find_or_create_by(:user_id => voter_id)
    @origin_users = Origin::User.all - @gonghui.res_list
  end

  def vote_user
    voter_id = session[:user_id]
    user_id = params[:user_id]
    if Vote::Gonghui.is_full?(voter_id)
      redirect_to :back, notice: '对不起，您的投票名额已满！'
    else
      Vote::Gonghui.vote_user(voter_id, user_id)
      redirect_to :back, notice: '投票成功！'
    end
  end

  def unvote_user
    voter_id = session[:user_id]
    user_id = params[:user_id]
    Vote::GonghuiUserRelation.where(:voter_id => voter_id, :user_id => user_id).each { |r| r.destroy }
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
end