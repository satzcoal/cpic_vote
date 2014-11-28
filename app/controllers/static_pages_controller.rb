class StaticPagesController < ApplicationController
  def home
    @votes = Vote::Vote.all
  end

  def page_403

  end
end
