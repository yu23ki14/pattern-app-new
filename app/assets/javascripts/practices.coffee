$(document).on 'turbolinks:load', ->
  $('.did').click ->
    $.post '/practices/' + $(this).attr('practice_id') + '/did'