json.array!(@vote_votes) do |vote_vote|
  json.extract! vote_vote, :id, :name, :start_time, :stop_time, :url
  json.url vote_vote_url(vote_vote, format: :json)
end
