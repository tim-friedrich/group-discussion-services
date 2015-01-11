class UserMailer < ActionMailer::Base
  default from: "info@group-discussion-services.de"

  def invitation_to_discussion(discussions_user)
    @discussions_user = discussions_user
    mail(to: @discussions_user.user.email, subject: 'Sie wurden zu einer Diskussion eingeladen!')
  end
end
