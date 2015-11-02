class UserMailer < ActionMailer::Base
  add_template_helper ApplicationHelper
  default from: "waschat@psychomatix.de"

  def invitation_to_discussion(discussions_user)
    @discussions_user = discussions_user
    mail(
      to: @discussions_user.user.email,
      subject: 'Sie wurden zu einer Diskussion eingeladen!'
    )
  end

  def survey(user)
    @user = user
    @survey = @user.survey
    @survey.singleton_class.include SurveyDecorator
    mail(
      to: @user.email,
      subject: 'Ergebnisse Ihres Persönlichkeitstests',
    )
  end
end
