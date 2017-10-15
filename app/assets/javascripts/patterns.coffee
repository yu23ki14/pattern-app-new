$(document).on 'turbolinks:load', ->
  $('#fav').click ->
    $.post '/patterns/' + $(this).attr('lg_code') + '/' + $(this).attr('pattern_no') + '/' + $(this).attr('user_id') + '/fav'