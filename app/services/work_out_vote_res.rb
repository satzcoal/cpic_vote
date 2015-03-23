class WorkOutVoteRes
  def call
    @vote.items.each do |item|
      res = Vote::VoteRes.find_or_create_by(:vote_id => @vote.id, :item_id => item.id)
      res.update(res_info: {total: item.ins_votes.count}, index: item.ins_votes.count, item: item)
    end
  end

  def initialize(vote)
    @vote = vote
  end

  def self.call(vote)
    new(vote).call
  end
end