require 'rails_helper'

describe WorkOutVoteRes do
  it "should called from a class method" do
    WorkOutVoteRes.call Vote::VoteMain.new
  end

  it "should called from a instance method" do
    vote = Vote::VoteMain.new
    vote.items.build
    vote.items.build
    service = WorkOutVoteRes.new vote
    service.call
    expect(vote.items.size).to eq(vote.results.size)
  end
end