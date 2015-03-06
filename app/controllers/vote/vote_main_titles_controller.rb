# encoding: utf-8
class Vote::VoteMainTitlesController < ApplicationController
  before_action :set_vote, only: [:title_down, :title_up, :title_edit, :titles_update]

  def title_up
    @vote.swap_titles(params[:title_index], params[:title_index].to_i - 1)
    redirect_to :back, notice: "操作成功！"
  end

  def title_down
    @vote.swap_titles(params[:title_index], params[:title_index].to_i + 1)
    redirect_to :back, notice: "操作成功！"
  end

  def title_edit
    @vote.titles[params[:title_index]]
    @title_line = @vote.titles.sort[params[:title_index].to_i]
    respond_to do |format|
      format.js
    end
  end

  def titles_update
    btn = params.find { |k, v| v == '保存' }
    index = btn[0].split('_').last
    line_arr = params.select { |k, v| k.split('_').first == ('title' + index) }
    line_arr = line_arr.map do |item|
      tmp = item[0].split('_')
      tmp.delete_at(0)
      [tmp.join('_'), item[1]]
    end

    line_arr.each do |pair|
      @vote.titles[index][pair[0]] = pair[1]
    end

    @vote.titles_will_change!
    @vote.save

    @title_line = @vote.titles.sort[index.to_i]
    @total_num = @vote.titles.count
    respond_to do |format|
      format.js
    end
  end

  private
  def set_vote
    @vote = Vote::VoteMain.find(params[:id])
  end
end
