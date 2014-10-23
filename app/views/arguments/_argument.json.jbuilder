#json.extract! argument, :argument_type, :votes, :user_id, :id

json.id argument.id
json.content argument.content
json.argument_type argument.argument_type.name
json.user_id argument.user_id
#json.is_voted argument.is_voted_from?(current_user)
json.created_at argument.created_at
