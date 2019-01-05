$ ->
  $('.js-follow-pattern').on 'click', (e) ->
    e.preventDefault()
    pattern_id = $(this).attr("pattern_id")
    type = $(this).attr("type")
    data = {pattern_id: pattern_id, type: type}
    $.ajax(
      url: '/user_interests'
      type: 'GET'
      data: data
      dataType: 'json'
      context: this).done((data) ->
      if data["result"] == "created"
        $(this).attr('type', 'delete').text("フォローを外す").toggleClass("button-outline button-primary")
      else if data["result"] == "deleted"
        $(this).attr('type', 'create').text("フォローする").toggleClass("button-outline button-primary")
      else
        alert 'フォローできませんでした。'
      return
    ).fail ->
      alert 'フォローできませんでした。'
      return
    return