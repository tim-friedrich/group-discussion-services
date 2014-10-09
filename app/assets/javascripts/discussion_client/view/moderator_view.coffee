#= require discussion_client/view/view

class @ModeratorView extends View

  draw_voting: (argument) =>
    dom_element =
      """
        <span class="vote_count badge like_badge">#{ argument.num_likes() }</span>
				<span class="vote_count badge dislike_badge" >#{ argument.num_dislikes() }</span>
      """
    $(argument.dom_element).find(".right_argument").prepend(dom_element)

  draw_argument: () =>
    super
    if @participation_chart?
      @update_participation()

  update_voting: (argument) =>
    argument.dom_element.find('.vote_count').remove()
    @draw_voting(argument)

  draw_toolbox: () =>
    super
    @draw_participation()

  draw_participation: () =>
    content_dom =
      """
        <div class="tab-pane" id="participation">
          <canvas id="chart" width="180" height="180"></canvas>
        </div>
      """

    $(".toolbox").find("#users").append(content_dom)
    data = []
    $.each(@discussion.users, ((index, user) =>
      if user != @discussion.moderator
        data.push(
          value: user.argument_count()
          color: user.color
          label: user.name
        )
    ))

    ctx = $("#participation").find("#chart").get(0).getContext("2d");
    @participation_chart = new Chart(ctx).Doughnut(data);

  update_participation: () =>
    $.each(@participation_chart.segments, (index, segment) =>
      user = @discussion.users.filter((user) => user.name == segment.label)[0]
      segment.value = user.argument_count()
    )
    @participation_chart.update()

