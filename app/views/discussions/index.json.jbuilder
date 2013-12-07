json.array!(@discussions) do |discussion|
  json.extract! discussion, :topic, :moderator, :due_date
  json.url discussion_url(discussion, format: :json)
end
