class @Argument
  constructor: (@id, @content, @user, @timestamp, @discussion, @type, @votes = []) ->


  vote: (is_like) =>
    $.post(
      "/votes",
      vote:
        argument_id: @id
        is_like: is_like
    )

  num_likes: () =>
    likes = @votes.filter((vote) => vote.is_like)
    return likes.length

  num_dislikes: () =>
    dislikes = @votes.filter((vote) => (not vote.is_like))
    return dislikes.length

  add_vote: (vote) =>
    @votes.push(vote)
    @discussion.view.update_voting(@)

  generate_dom: () =>
    @dom_element =
    """
      <div class="argument">
        <div class="user">
          <div class="name">#{ @user.name }:</div>
          <div class="color" style='background-color: #{ @user.color }'></div>
        </div>
        <div class="arrow">
          <img src="#{image_path('discussion/argument_arrow.png')}" />
        </div>
        <div class="argument_content">
          #{ $.emoticons.replace(@content) }
        </div>
      </div>
    """
    if @type == 'observer'
      @dom_element = $(@dom_element).addClass('observer_argument')

  is_voted: () =>
    return @votes.filter((vote) => vote.user_id == @discussion.current_user.id)?.length >= 1
