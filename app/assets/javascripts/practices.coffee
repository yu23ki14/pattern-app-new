$(document).on 'turbolinks:load', ->
  if $("body").hasClass("practices")
    $('#practicecontent').on 'click', '.did', ->
      $.post '/practices/' + $(this).attr('practice_id') + '/did'
      $('#did-notification').delay(100).animate({'z-index': 1}, 1).animate({opacity: 1}, 200).delay(700).animate({opacity: 0}, 200).animate({'z-index': 0}, 1)
      
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
        
    $('#practicecontent').on 'click', '.js-trigger-practice-comment', ->
      $.ajax(
        type: 'GET',
        url: 'practices/' + $(this).attr('practice_id') + '/practice_comment'
      ).done ->
        $('#practice-comment').modal()
      
    $('#active-list').click ->
      $("li").removeClass("active")
      $(this).addClass("active")
    $('#complete-list').click ->
      $("li").removeClass("active")
      $(this).addClass("active")
    $('#archive-list').click ->
      $("li").removeClass("active")
      $(this).addClass("active")
    
    