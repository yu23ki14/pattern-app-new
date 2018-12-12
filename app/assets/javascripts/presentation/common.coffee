$(document).on "turbolinks:load", ->
  window_height = $(window).height()
  
  $(".alert").delay(1300).fadeOut("normal")
  
  $(document).on 'click', '.close-modal', (e) ->
    $('.modal').modal('hide')
    return false