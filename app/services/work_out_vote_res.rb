class WorkOutVoteRes
  def call
    @vote.items.each do |item|
      @vote.results.build(res_info: {total: item.ins_votes.count}, index: item.ins_votes.count, item: item)
    end
  end

  def initialize(vote)
    @vote = vote
  end

  def self.call(vote)
    new(vote).call
  end
end