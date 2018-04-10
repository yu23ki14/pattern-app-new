$(document).on 'turbolinks:load', ->
  if $("body").hasClass("shuffles")
    setCardheight = ->
      card_height = $(".card").height()
      $(".card-stack").css("height", card_height + 15)
    setTimeout ->
      setCardheight()
    , 50
  
    cards = $(".card").length
    card = cards
  
    $(document).on 'click', '.js-trigger-previous',->
      if card != cards
        $(".card:nth-of-type(" + card + ")").css("right", "400px")
        card += 1
        setTimeout ->
          $(".card:nth-of-type(" + card + ")").css("right", "0px")
        , 500
        
      return false
      
    $(document).on 'click', '.js-trigger-next',->
      if card > 1
        $(".card:nth-of-type(" + card + ")").css("right", "-800px")
        card -= 1
        setTimeout ->
          $(".card:nth-of-type(" + card + ")").css("right", "0px")
        , 500
        
      return false