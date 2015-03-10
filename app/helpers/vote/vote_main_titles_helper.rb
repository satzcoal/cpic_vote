#encoding: utf-8
module Vote::VoteMainTitlesHelper
  def vote_item_op_button(url, index, total_num)
    res = ''
    res += link_to '修改', "#{url}/#{index}/edit", :remote => true
    res += ' ' + (link_to ' 上移', "#{url}/#{index}/up") unless index.to_s == '0'
    res += ' ' + (link_to ' 下移', "#{url}/#{index}/down") unless index.to_s == (total_num - 1).to_s
    res.html_safe
  end
end
