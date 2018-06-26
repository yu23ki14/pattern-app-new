$(document).on 'turbolinks:load', ->
  if $("body").hasClass("shuffles")
    setCardheight = ->
      element = $(".card")
      count = element.length
      ele_height = []
      i = 0
      while i < count
        ele_height[i] = element.eq(i).height()
        i++
      max_height = Math.max.apply(null, ele_height) + 100
      $(".card-stack").css("height", max_height)
    setTimeout ->
      setCardheight()
    , 50
  
    cards = $(".card").length
    card = 1
    front_card = 2
    
    $(document).on 'click', '.js-trigger-show',->
      if front_card <= cards
        $(".card").removeClass("box-shadow-primary").removeClass("visible")
        $(".card:nth-of-type(" + front_card + ")").addClass("show").addClass("box-shadow-primary").addClass("visible")
        $(".card").css({"right" : "0", "left" : "0"})
        front_card += 1
        card = front_card-1
      return false
  
    
    $(document).on 'click', '.js-trigger-previous',->
      if card >= 2
        $(".card:nth-of-type(" + card + ")").addClass("box-shadow-primary")
        $(".card:nth-of-type(" + card + ")").css("left" : "-800px")
        card -= 1
        $(".card:nth-of-type(" + card + ")").addClass("box-shadow-primary").addClass("visible")
      return false
      
    $(document).on 'click', '.js-trigger-next',->
      if card <= front_card - 2
        $(".card:nth-of-type(" + card + ")").removeClass("box-shadow-primary").removeClass("visible")
        card += 1
        $(".card:nth-of-type(" + card + ")").css({"right" : "0", "left" : "0"}).addClass("visible")
        
      return false
    
    $('.fav').click ->
      $.post '/patterns/' + $(this).attr('language_id') + '/' + $(this).attr('pattern_no') + '/fav'