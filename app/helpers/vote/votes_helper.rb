#encoding: utf-8
module Vote::VotesHelper
  def vote_index_op_buttom(vote)
    res = ''
    case vote.status
      when 0 then
        res += (link_to '启用', "/vote/votes/#{vote.id}/prepare") + ' '
      when 1 then
        res += (link_to '开始投票', "/vote/votes/#{vote.id}/begin") + ' '
      when 2 then
        res += (link_to '结束投票', "/vote/votes/#{vote.id}/finish") + ' '
      when 3 then
        res += (link_to '公布结果', "/vote/votes/#{vote.id}/publish") + ' '
    end

    res + (link_to '禁用', "/vote/votes/#{vote.id}/destroy")
  end
end