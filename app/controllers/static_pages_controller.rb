class StaticPagesController < ApplicationController
  def home
    @cur_votes = Vote::Vote.where(:status => 1).order(:start_time)
    @will_votes = Vote::Vote.where(:status => 0).order(:start_time)
    @done_votes = Vote::Vote.where(:status => 2).order(:start_time)
  end

  def page_403

  end
end
