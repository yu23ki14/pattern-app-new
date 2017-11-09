$(document).on 'turbolinks:load', ->  
  #modalclosescript
  $('.close-modal').click ->
    $('.modal').modal('hide')
  $('#practicecontent').on 'click', '.close-modal', ->
    $('.modal').modal('hide')