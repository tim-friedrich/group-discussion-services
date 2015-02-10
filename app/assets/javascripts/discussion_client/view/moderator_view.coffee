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
    @draw_visual_aids_tab()

  draw_visual_aids_tab: () =>
    $('.toolbox').find(".nav-tabs").append(
      """
        <li>
          <a href="#visual_aids" role="tab" data-toggle="tab">Medien</a>
        </li>
      """
    )

    $('.toolbox').find('.tab-content').append(
      """
        <div class="tab-pane" id="visual_aids">
          <div class="list-group"></div>
        </div>
      """
    )

    $.each(@discussion.visual_aids, (index, visual_aid) =>
      list_group = $('#visual_aids').find('.list-group')
      list_group.append(
        """
          <a href="#" class="list-group-item" id="#{ visual_aid.id }">#{ visual_aid.name }</a>
        """
      )
      $(list_group.children()[list_group.children().length-1]).on('click', (event) =>
        list_group.children().removeClass('active')
        visual_aid.send_command('open')
        $(event.target).addClass('active')
        @resize()
      )
    )


  draw_participation: () =>
    content_dom =
      """
        <div class="tab-pane" id="participation">
          <h3>Beteiligung</h3>
          <canvas id="chart" width="180" height="180"></canvas>
        </div>
      """
    @init_participation_diagram = true
    $('#participation').remove()
    $(".toolbox").find("#users").append(content_dom)
    data = []

    $.each(@discussion.users, (index, user) =>
      if user.role != 'moderator' and user.role != 'observer'
        if user.argument_count() != 0
          @init_participation_diagram = false

        data.push(
          value: user.argument_count()
          color: user.color
          label: user.name
        )
    )

    ctx = $("#participation").find("#chart").get(0).getContext("2d");
    @participation_chart = new Chart(ctx).Doughnut(data);

  update_participation: () =>
    if @init_participation_diagram
      @draw_participation()

    $.each(@participation_chart.segments, (index, segment) =>
      user = @discussion.users.filter((user) => user.name == segment.label)[0]
      segment.value = user.argument_count()
    )
    @participation_chart.update()

