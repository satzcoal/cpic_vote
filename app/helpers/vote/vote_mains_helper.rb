#encoding: utf-8
module Vote::VoteMainsHelper
  def vote_index_op_button(vote)
    res = ''
    res += (link_to '启用', "/vote/vote_mains/#{vote.id}/enable") + ' ' if vote.status == 0 || vote.status > 99
    case vote.status
      when 1 then
        res += (link_to '开始投票', "/vote/vote_mains/#{vote.id}/process") + ' '
      when 2 then
        res += (link_to '结束投票', "/vote/vote_mains/#{vote.id}/finish") + ' '
      when 3 then
        res += (link_to '公布结果', "/vote/vote_mains/#{vote.id}/publish") + ' '
      when 3, 4 then
        res += (link_to '归档', "/vote/vote_mains/#{vote.id}/close") + ' '
    end
    res += (link_to '禁用', "/vote/vote_mains/#{vote.id}/disable") if vote.status < 100

    res.html_safe
  end

  def time_format(time, pattern='%Y-%m-%d %H:%M:%S')
    if time.present?
      return time.localtime.strftime(pattern)
    else
      return ''
    end
  end
end