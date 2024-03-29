class DiscussionMailer < ActionMailer::Base
  default to: "waschat@psychomatix.de"

  def new_discussion(discussion, user)
  	@discussion = discussion
  	@current_user = user
    mail(from: 'info@group-discussion-services.de', subject: 'Eine neue Diskussion wurde angefragt.')
  end
end
