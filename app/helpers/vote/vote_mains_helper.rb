#encoding: utf-8
module Vote::VoteMainsHelper
  def vote_index_op_buttom(vote)
    res = ''
    case vote.status
      when 0 then
        res += (link_to '启用', "/vote/vote_mains/#{vote.id}/prepare") + ' '
      when 1 then
        res += (link_to '开始投票', "/vote/vote_mains/#{vote.id}/begin") + ' '
      when 2 then
        res += (link_to '结束投票', "/vote/vote_mains/#{vote.id}/finish") + ' '
      when 3 then
        res += (link_to '公布结果', "/vote/vote_mains/#{vote.id}/publish") + ' '
    end

    (res + (link_to '禁用', "/vote/vote_mains/#{vote.id}/destroy")).html_safe
  end

  def time_format(time, pattern='%Y-%m-%d %H:%M:%S')
    if time.present?
      return time.localtime.strftime(pattern)
    else
      return ''
    end
  end
end