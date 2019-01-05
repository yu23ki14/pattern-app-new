$ ->
  if $("body").hasClass("posts edit") || $("body").hasClass("posts new")
    editor = new MediumEditor('.post-content-preview', {
        placeholder:
          text: "本文を書く"
          hideOnClick: "true"
      })
    
    setInterval ->
      $("#presentation_post_content").val(editor.getContent())
    , 500
    
    if $("body").hasClass("posts edit")
      post_content = gon.post_content
      editor.setContent(post_content)
      
    $('#new_presentation_post, .edit_presentation_post').on 'submit', ->
      if $("#related_patterns").val().length < 3
        alert "関連パターンは一つ以上登録してください。"
        return false
      else if $("#presentation_post_title").val().length < 1
        alert "タイトルは必須です。"
        return false
      else if $(".post-content-preview").text().length < 1
        alert "本文は必須です。"
        return false
  
  #editor.setContent('<p class="classy"><strong>Some Custom HTML</strong></p>')

  $(document).on 'click', ".js-trigger-web-reference-modal", ->
    referer = $(this).attr("referer")
    if referer == "web"
      $(".post-reference-form-modal").modal()
      $(".post-reference").removeClass("hide")
      $(".post-link").removeClass("hide")
    else if referer == "book"
      $(".post-reference").removeClass("hide")
      $(".post-reference-store").removeClass("hide")
    return false
  
  $(document).on 'click', ".js-post-input-hide", ->
    $(this).parent().addClass("hide")
    $(this).prev().val("")
    
  $(document).on 'click', ".js-get-reference-info", ->
    $(".loading-modal").css("display", "block")
    $.ajax
      url: "posts/get_web_reference",
      type: "get"
      success: (data)->
        $(".loading-modal").css("display", "none")
        editor.setContent(data["test_data"])
        $('.post-reference-form-modal').modal('hide')
    return false
    
  $(document).on 'click', ".js-trigger-post-pattern-selector", (e)->
    e.preventDefault()
    $(".related_pattern_selector_modal").modal()
    if $("#related_patterns").val().length > 0
      for pattern_id in JSON.parse($("#related_patterns").val())
        $(".related_pattern_selector_modal a[pattern_id='" + pattern_id + "']").addClass("active")
  
  $(document).on 'click', ".js-select-related-pattern", (e)->
    e.preventDefault()
    $(this).toggleClass("active")
    pattern_name = $(this).text()
    pattern_id = parseInt($(this).attr("pattern_id"))
    current_value = $("#related_patterns").val()
    
    if current_value != ""
      update_value = JSON.parse(current_value)
      if current_value.indexOf(pattern_id) == -1
        update_value.push(pattern_id)
        $(".js-post-related-pattern-list").append("<p class='inline p-x-10 id-" + pattern_id + "'>" + pattern_name + "</p>")
      else
        index = update_value.indexOf(pattern_id)
        update_value.splice(index,1)
        $(".js-post-related-pattern-list .id-" + pattern_id).remove()
    else
      update_value = []
      update_value.push(pattern_id)
      $(".js-post-related-pattern-list").append("<p class='inline p-x-10 id-" + pattern_id + "'>" + pattern_name + "</p>")
      
    $("#related_patterns").val(JSON.stringify(update_value))
  
  $('#presentation_post_thumb_image').change ->
    console.log("tst")
    file = $(this).prop('files')[0]
    reader = new FileReader
    
    reader.onload = ->
      img_src = $('<img class="col-12">').attr('src', reader.result)
      $(".js-thumb-image-label").css("background", "transparent")
      $(".js-thumb-image-label").html img_src
    
    reader.readAsDataURL file
    
  $('#new_presentation_post_comment').on 'submit', (e) ->
    e.preventDefault()
    formData = new FormData(this)
    url = $(this).attr('action')
    # Ajax処理
    $.ajax(
      url: url
      type: 'POST'
      data: formData
      dataType: 'json'
      processData: false
      contentType: false).done((data) ->
      if data["result"] == "success"
        new_comment = "<h5 class='m-b-0'>" + data["user_name"] + "</h5><p class='p-b-5 p-l-10'>" + data["comment"] + "</p>"
        $(".js-post-no-comment").remove()
        $(".js-post-comment-list").prepend(new_comment)
        $("#presentation_post_comment_comment").val("")
        $('#new_presentation_post_comment input[type="submit"]').removeAttr 'disabled'
      else
        alert 'メッセージの送信に失敗しました。'
        $('#new_presentation_post_comment input["submit"]').removeAttr 'disabled'
      return
    ).fail ->
      alert 'メッセージの送信に失敗しました。'
      $('#new_presentation_post_comment input["submit"]').removeAttr 'disabled'
      return
    return
    
  $('.js-post-stock').on 'click', (e) ->
    e.preventDefault()
    user_id = $(this).attr("user_id")
    post_id = $(this).attr("post_id")
    type = $(this).attr("type")
    data = {post_id: post_id, type: type}
    $.ajax(
      url: '/stocks'
      type: 'GET'
      data: data
      dataType: 'json').done((data) ->
      if data["result"] == "created"
        $(".js-post-stock").attr('type', 'delete').text("ストックから外す").toggleClass("button-outline button-primary")
      else if data["result"] == "deleted"
        $(".js-post-stock").attr('type', 'create').text("ストックする").toggleClass("button-outline button-primary")
      else
        alert 'ストックできませんでした。'
      return
    ).fail ->
      alert 'ストックできませんでした。'
      return
    return