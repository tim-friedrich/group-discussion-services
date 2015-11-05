json.array!(@discussion.users) do |user|
  json.confirmed_discussion @discussion.discussions_user_for(user).confirmed
  json.discussions_user_id @discussion.discussions_user_for(user).id
  json.id user.id
  json.gender user.gender
  json.role user.role.name
  json.age user.age
  json.zipcode user.zipcode
  if user.has_survey?
    json.e user.survey.e
    json.n user.survey.n
    json.c user.survey.c
    json.a user.survey.a
    json.o user.survey.o
    json.lm user.survey.lm
    json.mm user.survey.mm
    json.sm user.survey.sm
    json.h user.survey.h
    json.school t("survey.school.#{user.survey.school}") if user.survey.school
    json.degree t("survey.degree.#{user.survey.degree}") if user.survey.degree
    json.personal_status t("survey.personal_status.#{user.survey.personal_status}") if user.survey.personal_status
    json.income t("survey.income.#{user.survey.income}") if user.survey.income
  end
end
