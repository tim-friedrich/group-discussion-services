json.array!(@group_discussions) do |group_discussion|
  json.extract! group_discussion, 
  json.url group_discussion_url(group_discussion, format: :json)
end
