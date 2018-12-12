$(document).on 'turbolinks:load', ->
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
    
  $(document).on 'click', ".js-trigger-post-pattern-selector", ->
    $(".related_pattern_selector_modal").modal()
    return false
  
  $(document).on 'click', ".js-post-input-hide", ->
    $(this).parent().addClass("hide")
    
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
  
  $(document).on 'click', ".js-select-related-pattern", (e)->
    e.preventDefault()
    $(this).toggleClass("active")
    pattern_name = $(this).text()
    pattern_no = parseInt($(this).attr("pattern_no"))
    current_value = $("#presentation_post_pattern").val()
    
    if current_value != ""
      update_value = JSON.parse(current_value)
      if current_value.indexOf(pattern_no) == -1
        update_value.push(pattern_no)
        $(".js-post-related-pattern-list").append("<p class='inline p-x-10 no-" + pattern_no + "'>" + pattern_name + "</p>")
      else
        index = update_value.indexOf(pattern_no)
        update_value.splice(index,1)
        $(".js-post-related-pattern-list .no-" + pattern_no).remove()
    else
      update_value = []
      update_value.push(pattern_no)
      $(".js-post-related-pattern-list").append("<p class='inline p-x-10 no-" + pattern_no + "'>" + pattern_name + "</p>")
      
    $("#presentation_post_pattern").val(JSON.stringify(update_value))
  
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
        new_comment = "<p>test</p>"
        $(".js-post-no-comment").remove
        $(".js-post-comment-list").append(new_comment.html)
      else
        alert 'メッセージの送信に失敗しました。'
      return
    ).fail ->
      alert 'メッセージの送信に失敗しました。'
      return
    return