$(document).on 'turbolinks:load', ->
  $('#fav').click ->
    $.post '/patterns/' + $(this).attr('language_id') + '/' + $(this).attr('pattern_no') + '/fav'
  $('#js-trigger-add-practice').click ->
    $('#add-practice').modal()

  $(".alert").delay(1300).fadeOut("normal")