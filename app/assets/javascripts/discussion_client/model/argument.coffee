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
      <div class="list-group-item argument-panel clearfix">
        <div class="left_argument">
          <div class="color" style='background-color: #{ @user.color }'></div>
          <div class="name">#{ @user.name }:</div>
          <div class="argument"></span> #{ $.emoticons.replace(@content) }</div>
        </div>
        <div class="right_argument pull-right">
          <span class = "time_stamp">#{ @timestamp.toString("HH:mm") }</span>
        </div>
      </div>
    """

  is_voted: () =>
    console.log(@votes)
    console.log(@votes.filter((vote) => vote.user_id == @discussion.current_user.id))
    return @votes.filter((vote) => vote.user_id == @discussion.current_user.id)?.length >= 1
