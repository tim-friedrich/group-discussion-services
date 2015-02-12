class DiscussionPresence < ActiveRecord::Base
  belongs_to :discussions_user

  def user
    self.discussions_user.user
  end

  def discussion
    self.discussions_user.discussion
  end
end
