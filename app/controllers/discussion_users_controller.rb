class DiscussionUsersController < ApplicationController
 def create
    @discussion_user = DiscussionUser.new(discussion_user_params)
puts "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAa"
    respond_to do |format|
      if @discussion_user.save
        format.html { redirect_to @discussion_user, notice: 'Eine neue Diskussion wurde erfolgreich erstellt.' }
        format.json { render action: 'show', status: :created, location: @discussion }
      else
        format.html { render action: 'new' }
        format.json { render json: @discussion_user.errors, status: :unprocessable_entity }
      end
    end
  end
end
