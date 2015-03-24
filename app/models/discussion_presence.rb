class DiscussionPresence < ActiveRecord::Base
  belongs_to :discussions_user

  def user
    discussions_user.user
  end

  def discussion
    discussions_user.discussion
  end
end
