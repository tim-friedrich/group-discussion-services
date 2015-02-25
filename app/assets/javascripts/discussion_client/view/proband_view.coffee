#= require discussion_client/view/view

class @ProbandView extends View

  draw_voting: (argument) =>
    if @discussion.current_user == argument.user
      return

    voting_template =
      """
        <div id="like_button" class="btn btn-success btn-xs vote_button">
          <i class='glyphicon glyphicon-thumbs-up' ></i>
        </div>
        <div id="dislike_button" class="btn btn-danger btn-xs vote_button">
          <i class='glyphicon glyphicon-thumbs-down' ></i>
        </div>
      """
    $(argument.dom_element).find(".argument_content").append(voting_template)
    $like_button = $(argument.dom_element).find("#like_button")
    $dislike_button = $(argument.dom_element).find("#dislike_button")

    if argument.is_voted()
      $like_button.addClass("disabled")
      $dislike_button.addClass("disabled")
    else
      $like_button.on("click", (event) =>
        argument.vote(true)
        $like_button.addClass("disabled")
        $dislike_button.addClass("disabled")
      )
      $dislike_button.click((event) =>
        argument.vote(false)
        $like_button.addClass("disabled")
        $dislike_button.addClass("disabled")
      )

  draw_toolbox: () =>
    template = 
      """
        <img id="welcome_slogan" src="#{ image_path('discussion/welcome.png') }">
        <div>
          <h2>Thema</h2>
          <hr>
          <p>#{ @discussion.topic }</p>
          <h2>Teilnehmer</h2>
          <hr>
          <div id="probands-list"></div>
        </div>
      """
    $(".toolbox").append(template)

    @draw_probands_list()

