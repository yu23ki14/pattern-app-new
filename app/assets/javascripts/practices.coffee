$(document).on 'turbolinks:load', ->
  if $("body").hasClass("practices")
    $('.did').click ->
      $.post '/practices/' + $(this).attr('practice_id') + '/did'
    $('#practicecontent').on 'click', '.did', ->
      $.post '/practices/' + $(this).attr('practice_id') + '/did'
      
    $('.js-trigger-add-comment').click ->
      $('#add_comment').modal()
    $('#practicecontent').on 'click', '.js-trigger-add-comment', ->
      $.ajax(
        type: 'GET',
        url: 'practices/' + $(this).attr('pid') + '/addcomment'
      ).done ->
        $('#add_comment').modal()
    
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