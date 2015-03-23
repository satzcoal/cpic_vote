class StaticPagesController < ApplicationController
  def home
    @cur_votes = Vote::VoteMain.where(:status => Vote::VoteMain::STATUS_PROCESS).order(:start_time)
    @will_votes = Vote::VoteMain.where(:status => Vote::VoteMain::STATUS_ENABLE).order(:start_time)
    @done_votes = Vote::VoteMain.where(:status => [Vote::VoteMain::STATUS_FINISH, Vote::VoteMain::STATUS_PUBLISH]).order(:start_time)
  end

  def page_403

  end
end
