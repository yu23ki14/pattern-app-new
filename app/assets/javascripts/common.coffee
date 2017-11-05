$(document).on 'turbolinks:load', ->  
  #modalclosescript
  $('.close-modal').click ->
    $('.modal').modal('hide')