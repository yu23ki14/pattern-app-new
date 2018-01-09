$(document).on 'turbolinks:load', ->
  $('#nav-open-btn').click ->
    $('body').addClass('nav-open')
  $('#nav-close-btn').click ->
    $('body').removeClass('nav-open')
  $('#pickup-fav').click ->
    $('body').addClass('pickup-fav')
    
  $('.js-trigger-edit-password').click ->
    $('.password-container').addClass('open')
    return false

$(document).on 'turbolinks:request-start', ->
  $('body').removeClass('nav-open')