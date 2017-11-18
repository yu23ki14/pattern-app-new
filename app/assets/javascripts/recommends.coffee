$(document).on "turbolinks:load", ->
  $("#phase-1 .text-box:eq(0)").hide().delay(1000).fadeIn("200")
  $("#phase-1 .text-box:eq(1)").hide().delay(3000).fadeIn("200")
  $("#phase-1 .text-box:eq(2)").hide().delay(5000).fadeIn("200")
  $("#phase-1 .choices-container").hide().delay(7000).fadeIn("200")
  

  $("#phase-1").on "click", ".submit", ->
    #$.post "/recommends/" + $(this).attr("value") + "/new"
    $.ajax(
      type: "GET",
      url: "recommends/" + $(this).attr("value") + "/gophase2"
    ).done ->
      $("#phase-2 .text-box:eq(0)").hide().delay(1000).fadeIn("200")
      $("html,body").delay(1000).animate({scrollTop:$("#bottom").offset().top})
      $("#phase-2 .text-box:eq(1)").hide().delay(3000).fadeIn("200")
      $("html,body").delay(2000).animate({scrollTop:$("#bottom").offset().top})
      $("#phase-2 .choices-container").hide().delay(5000).fadeIn("200")
      $("html,body").delay(2000).animate({scrollTop:$("#bottom").offset().top})
      
  $("#phase-2").on "click", ".submit", ->
    $.ajax(
      type: "GET",
      url: "recommends/" + $(this).attr("value") + "/gophase3"
    ).done ->
      $("#phase-3 .text-box:eq(0)").hide().delay(1000).fadeIn("200")
      $("html,body").delay(1000).animate({scrollTop:$("#bottom").offset().top})
      $("#phase-3 .text-box:eq(1)").hide().delay(3000).fadeIn("200")
      $("html,body").delay(2000).animate({scrollTop:$("#bottom").offset().top})
      $("#phase-3 .choices-container").hide().delay(5000).fadeIn("200")
      $("html,body").delay(2000).animate({scrollTop:$("#bottom").offset().top})
      
  $("#phase-3").on "click", ".submit", ->
    $.ajax(
      type: "GET",
      url: "recommends/" + $(this).attr("value") + "/gophase4"
    ).done ->
      $("#phase-4 .text-box:eq(0)").hide().delay(1000).fadeIn("200")
      $("html,body").delay(1000).animate({scrollTop:$("#bottom").offset().top})
      $("#phase-4 .text-box:eq(1)").hide().delay(3000).fadeIn("200")
      $("html,body").delay(2000).animate({scrollTop:$("#bottom").offset().top})
      $("#phase-4 .choices-container").hide().delay(5000).fadeIn("200")
      $("html,body").delay(2000).animate({scrollTop:$("#bottom").offset().top})
      
  $("#phase-4").on "click", ".submit", ->
    $.ajax(
      type: "GET",
      url: "recommends/" + $(this).attr("value") + "/gorecommend"
    ).done ->
      $("#recommend .text-box:eq(0)").hide().delay(1000).fadeIn("200")
      $("html,body").delay(1000).animate({scrollTop:$("#bottom").offset().top})
      $("#recommend .text-box:eq(1)").hide().delay(3000).fadeIn("200")
      $("html,body").delay(2000).animate({scrollTop:$("#bottom").offset().top})
      $("#recommend .choices-container").hide().delay(5000).fadeIn("200")
      $("html,body").delay(2000).animate({scrollTop:$("#bottom").offset().top})