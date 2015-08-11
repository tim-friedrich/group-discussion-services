@closeDiscussion = (e) ->
  e.preventDefault()
  discussionId = parseInt(document.location.pathname.split("/").slice(-2)[0])

  $.ajax(
    method: "patch"
    url: "/discussion_state/#{discussionId}"
    data: {
      discussion: {
        state: 'closed'
        state_message: 'Die Diskussion wurde geschlossen.'
      }
    }
  ).done ->
    window.onbeforeunload = null
    document.location.href = "/evaluations/#{discussionId}#summary"


# # # init

$('body').on 'click', '#close-discussion', @closeDiscussion
