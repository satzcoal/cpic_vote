class StaticPagesController < ApplicationController
  def home
    @cur_votes = Vote::VoteMain.where(:status => 1).order(:start_time)
    @will_votes = Vote::VoteMain.where(:status => 0).order(:start_time)
    @done_votes = Vote::VoteMain.where(:status => [2, 3]).order(:start_time)
  end

  def page_403

  end
end
