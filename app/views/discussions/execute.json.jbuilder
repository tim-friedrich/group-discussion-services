
json.discussion do
  json.id @discussion.id
  json.topic @discussion.topic
  json.moderator_id @discussion.moderator.id
  json.moderator_avatar @discussion.moderator_avatar
  json.due_date @discussion.due_date
  json.arguments @arguments, partial: 'arguments/argument', as: :argument
  json.questions @discussion.questions
  json.users @discussions_user, partial: 'discussions_users/user', as: :discussions_user
  json.votes @votes
  json.visual_aids @discussion.visual_aids, partial: 'visual_aids/visual_aid', as: :visual_aid
  json.visual_aids_logs @visual_aids_log
end
json.current_user_id current_user.id