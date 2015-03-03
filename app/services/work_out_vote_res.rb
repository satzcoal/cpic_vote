class WorkOutVoteRes
  def call

  end

  def initialize(vote)
    @vote = vote
  end

  def self.call(vote)
    new(vote).call
  end
end