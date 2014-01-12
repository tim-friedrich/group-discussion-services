json.array!(@dislikes) do |dislike|
  json.extract! dislike, :argument_id, :user_id
  json.url dislike_url(dislike, format: :json)
end
