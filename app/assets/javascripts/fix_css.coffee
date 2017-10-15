$(document).on 'turbolinks:load', ->
  card_height = $(".card1").width()*1.4
  pattern_content_height = $(".pattern_content").height()
  fix_card1_height = ->
    $(".card1").css("height", card_height)
  fix_card1_height()
  $(window).resize ->
    fix_card1_height()

