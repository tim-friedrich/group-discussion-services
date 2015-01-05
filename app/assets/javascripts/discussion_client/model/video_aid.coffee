#= require discussion_client/model/visual_aid
#=require discussion_client/media_element_player_ws

class @VideoAid extends VisualAid

  constructor: ->
    super
    @commands['play'] = () => @start_player()
    @commands['pause'] = () => @pause_player()
    @commands['time_update'] = (time) => @time_update(time)

    @visual_aid =
      """
        <div id="visual_aid_container">
          <video src="#{ @url }" id="visual_aid_video" class="mejs-player"></video>
        </div>
      """
    @can_control = @discussion.current_user.is_moderator()

  open: () =>
    super
    @init_player()

  init_player: () =>
    @last_current_time = 0
    $('.top').height('auto')
    unless @can_control
      control_options = []
    else
      control_options = ['playpause','progress','current','duration','tracks','volume','fullscreen']

    #initialize the mediaElementPlayer object
    @player = new MediaElementPlayer('#visual_aid_video',
      features: control_options
      enableAutoSize: false
      enableKeyboards: false
      keyActions: []
      success: (mediaElement, domObject) =>
        @discussion.view.resize()
        mediaElement.addEventListener('play', (e) =>
          #pause the video if the user is not allowed to start it
          @player.pause() unless @can_start
          @send_command('play') if @can_control
          @send_command('time_update', mediaElement.currentTime) if @can_control
        ,false);

        mediaElement.addEventListener('pause', (e) =>
          @send_command('pause') if @can_control
        )
        mediaElement.addEventListener('timeupdate', (e) =>
          if @can_control
            current_time = mediaElement.currentTime
            @send_command('time_update', current_time) if current_time - @last_current_time > 1 || current_time - @last_current_time < 0
            @last_current_time = mediaElement.currentTime
        )

    )

    #if the current user is not the moderator make sure that he can not control the player
    unless @can_control
      $('.mejs-layers, .mejs-controls').hide()
      @can_start = false
    else
      @can_start = true
    @discussion.view.resize()

  time_update: (time) =>
    @player.media.currentTime = time unless @can_control

  start_player: () =>
    @can_start = true
    @player.play()

  pause_player: () =>
    @can_start = false unless @can_control
    @player.pause()

  register_send_start: () =>

  close: () =>
    @can_start = false unless @can_control

    container = $('.chat').find('.top')
    $('#visual_aid_container').remove()
    container.children().show()
    container.css('height', '125px')
    @discussion.view.resize()