$(document).on 'turbolinks:load', ->
  $('#fav').click ->
    $.post '/patterns/' + $(this).attr('language_id') + '/' + $(this).attr('pattern_no') + '/fav'
  $('#js-trigger-add-practice').click ->
    $('#add-practice').modal()
  $('#js-trigger-add-project-practice').click ->
    $('#add-project-practice').modal()

  if $("body").hasClass("languages")
    $('a').click ->
      $(this).addClass("disable")