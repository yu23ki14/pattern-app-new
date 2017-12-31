$(document).on "turbolinks:load", ->  
  #modalclosescript
  $(".close-modal").click ->
    $(".modal").modal("hide")
  $("#practicecontent").on "click", ".close-modal", ->
    $(".modal").modal("hide")
  $("#pattern-detail-container").on "click", ".close-modal", ->
    $(".modal").modal("hide")
  $("#practice-comment-container").on "click", ".close-modal", ->
    $(".modal").modal("hide")
    
  if $("body").hasClass("recommends")
    height = $(window).height()
    $("body").css("min-height", height + "px")