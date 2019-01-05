$ ->    
  
  current_page = parseInt($(".js-tutorial-page").attr("current-page"), 10)
  
  $('.js-tutorial-prev').on 'click', (e) ->
    e.preventDefault()
    if current_page > 1
      $(".js-tutorial-content > div").addClass("hide")
      current_page -= 1
      $(".js-tutorial-" + current_page).removeClass("hide")
      $(".js-tutorial-page").text(current_page + "/3")
      
  $('.js-tutorial-next').on 'click', (e) ->
    e.preventDefault()
    if current_page < 3
      $(".js-tutorial-content > div").addClass("hide")
      current_page += 1
      $(".js-tutorial-" + current_page).removeClass("hide")
      $(".js-tutorial-page").text(current_page + "/3")