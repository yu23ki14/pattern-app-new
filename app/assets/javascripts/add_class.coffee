$(document).on 'turbolinks:load', ->
  $('#nav-open-btn').click ->
    $('body').addClass('nav-open')
  $('#nav-close-btn').click ->
    $('body').removeClass('nav-open')

$(document).on 'turbolinks:request-start', ->
  $('body').removeClass('nav-open')