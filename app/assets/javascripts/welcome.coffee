$(document).on 'turbolinks:load', ->
  if $('body').hasClass('welcome')
    height = $(window).height()
    $('.page-container').css('min-height', height + 'px')