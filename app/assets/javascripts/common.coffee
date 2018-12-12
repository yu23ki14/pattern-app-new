$(document).on "turbolinks:load", ->  
  #modalclosescript
  $(".close-modal").click ->
    $(".modal").modal("hide")
  $("#practicecontent").on "click", ".close-modal", ->
    $(".modal").modal("hide")
  $("#pattern-detail-container").on "click", ".close-modal", ->
    $(".modal").modal("hide")
  $("#practice-comment-container").on "click", ".close-modal", ->
    $(".modal").modal("hide")
    
  $(document).on 'click', '.close-modal', (e) ->
    $('.modal').modal('hide')
    return false
  $(document).on 'click', '.modal-close', (e) ->
    $('.modal').modal('hide')
    return false
  $(document).on 'click', '[data-dismiss="modal"]', (e) ->
    $('.modal').modal('hide')
    return false
  $(document).on 'click', '[data-toggle="modal"]', (e) ->
    contentattr = $(this).attr('href')
    $(contentattr).modal()
    return false
    
  if $("body").hasClass("recommends")
    height = $(window).height()
    $("body").css("min-height", height + "px")
    
  #実践リスト共通JS
  if $("body").hasClass("practices") or $("body").hasClass("projects")
    #アーカイブに入れる時のレーティング
    $(document).on 'click', '.range-group>a',->
      index = $(this).index()
      $(this).siblings().removeClass 'on'
      i = 0
      while i < index
        $(this).parent().find('a').eq(i).addClass 'on'
        i++
      $(this).parent().find('.input-range').attr 'value', index
      return
    return
    
    $("li").click ->
      $('#practicecontent').css({opacity: '1'}).animate({opacity: '0'}, 300)
  
  #ローダー
  $(document).on 'click', 'input[type="submit"]',->
    $(".loading-modal").css("display", "block")
  
  #alert
  $(".alert").delay(1300).fadeOut("normal")

  #bodyのmin-heightをwindowのサイズに
  $("body").css("min-height", $(window).innerHeight() + "px")