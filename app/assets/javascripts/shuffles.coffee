$(document).on 'turbolinks:load', ->
  if $("body").hasClass("shuffles")
    setCardheight = ->
      $(".card-stack").css("height", 375)
    setTimeout ->
      setCardheight()
    , 50
  
    cards = $(".card").length
    card = 1
    front_card = 2
    
    $(document).on 'click', '.js-trigger-show',->
      if front_card <= cards
        $(".card").removeClass("box-shadow-primary")
        $(".card:nth-of-type(" + front_card + ")").addClass("show").addClass("box-shadow-primary")
        $(".card").css({"right" : "0", "left" : "0"})
        front_card += 1
        card = front_card-1
      return false
  
    
    $(document).on 'click', '.js-trigger-previous',->
      if card >= 2
        $(".card:nth-of-type(" + card + ")").addClass("box-shadow-primary")
        $(".card:nth-of-type(" + card + ")").css("left" : "-800px")
        card -= 1
        $(".card:nth-of-type(" + card + ")").addClass("box-shadow-primary")
      return false
      
    $(document).on 'click', '.js-trigger-next',->
      if card <= front_card - 2
        $(".card:nth-of-type(" + card + ")").removeClass("box-shadow-primary")
        card += 1
        
        $(".card:nth-of-type(" + card + ")").css({"right" : "0", "left" : "0"})
        
      return false
    
    $('.fav').click ->
      $.post '/patterns/' + $(this).attr('language_id') + '/' + $(this).attr('pattern_no') + '/fav'