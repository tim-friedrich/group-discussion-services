json.array!(@votes) do |vote|
  json.extract! vote, :argument_id, :user_id, :is_like
  json.url vote_url(vote, format: :json)
end
