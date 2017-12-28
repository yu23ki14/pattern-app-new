$(document).on 'turbolinks:load', ->
  if $("body").hasClass("projects")
    $('.did').click ->
      $.post '/projects/' + $(this).attr('practice_id') + '/did'
      $('#did-notification').delay(100).animate({'z-index': 1}, 1).animate({opacity: 1}, 200).delay(700).animate({opacity: 0}, 200).animate({'z-index': 0}, 1)
    $('#practicecontent').on 'click', '.did', ->
      $.post '/practices/' + $(this).attr('practice_id') + '/did'
      $('#did-notification').delay(100).animate({'z-index': 1}, 1).animate({opacity: 1}, 200).delay(700).animate({opacity: 0}, 200).animate({'z-index': 0}, 1)
      
    $('.js-trigger-add-comment').click ->
      $('#add_comment').modal()
    $('#practicecontent').on 'click', '.js-trigger-add-comment', ->
      $.ajax(
        type: 'GET',
        url: 'practices/' + $(this).attr('pid') + '/addcomment'
      ).done ->
        $('#add_comment').modal()
        $('.range-group').each ->
          i = 0
          while i < 5
            $(this).append '<a>'
            i++
          return
    
    $('#practicecontent').on 'submit', '.edit_practice', ->
      $.ajax
        url: $(this).attr('action'),
        type: $(this).attr('method'),
        data: $(this).serialize()
        success: ->
          $('#add_comment').modal('hide')
          $.ajax
            type: 'GET',
            url: 'practices/complete'
      return false
      
    $('#practicecontent').on 'click', '.js-trigger-pattern-detail', ->
      $.ajax(
        type: 'GET',
        url: 'practices/' + $(this).attr('language_id') + '/'+$(this).attr('pattern_no') + '/detail'
      ).done ->
        $('#pattern_detail').modal()
      
    $('#active-list').click ->
      $("li").removeClass("active")
      $(this).addClass("active")
    $('#complete-list').click ->
      $("li").removeClass("active")
      $(this).addClass("active")
    $('#archive-list').click ->
      $("li").removeClass("active")
      $(this).addClass("active")
    
    $("li").click ->
      $('#practicecontent').css({opacity: '1'}).animate({opacity: '0'}, 300)
      
    $(document).on 'click', '.range-group>a',->
      index = $(this).index()
      $(this).siblings().removeClass 'on'
      i = 0
      while i < index
        $(this).parent().find('a').eq(i).addClass 'on'
        i++
      $(this).parent().find('.input-range').attr 'value', index
      return
    return
