class @Argument
  constructor: (@id, @content, @user, @timestamp, @discussion, @type, @is_voted, @votes = []) ->
    @dom_element =
    """
      <div class="list-group-item argument-panel clearfix">
        <div class="left_argument">
          <div class="color" style='background-color: #{ @user.color }'></div>
          <div class="name">#{ @user.name }:</div>
          <div class="argument"></span> #{ @content }</div>
        </div>
        <div class="right_argument pull-right">
          <span class = "time_stamp">#{ @timestamp.toString("HH:mm") }</span>
        </div>
      </div>
    """

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

  bind_vote: (is_moderator) ->
    if @
      PrivatePub.subscribe("/discussion/"+@discussion.id+"/votes/new", (data) ->
        if(data.is_like)
          $("#like_badge_"+data.id).text((parseInt($("#like_badge_"+data.id).text())+1))
        else
          $("#dislike_badge_"+data.id).text((parseInt($("#dislike_badge_"+data.id).text())+1))
      )