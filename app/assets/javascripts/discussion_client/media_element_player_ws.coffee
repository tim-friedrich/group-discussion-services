class @MediaElementPlayerWs extends MediaElementPlayer

  setVisualAid: (visual_aid) =>
    @visual_aid = visual_aid
    @is_master = @visual_aid.discussion.current_user.is_moderator()

  currentTime: (time) =>
    super time
    console.log(time)
    @visual_aid.send_command('set_current_time', @currentTime()) if @is_master
