$(document).on 'turbolinks:load', ->
  
  if $("body").hasClass("projects")
    $('#project-practicecontent').on 'click', '.js-trigger-did', ->
      $.post '/project_practices/' + $(this).attr('practice_id') + '/did'
      $('#did-notification').delay(100).animate({'z-index': 1}, 1).animate({opacity: 1}, 200).delay(700).animate({opacity: 0}, 200).animate({'z-index': 0}, 1)
      
    $('#project-practicecontent').on 'click', '.js-trigger-add-comment', ->
      $.ajax(
        type: 'GET',
        url: '/project_practices/' + $(this).attr('pid') + '/addcomment'
      ).done ->
        $('#add_comment').modal()
        $('.range-group').each ->
          i = 0
          while i < 5
            $(this).append '<a>'
            i++
          return
          
    $('#project-practicecontent').on 'submit', '.edit_project_practice', ->
      template = $('#template_name', this).val()
      $.ajax
        url: $(this).attr('action'),
        type: $(this).attr('method'),
        data: $(this).serialize()
        success: ->
          $('#add_comment').modal('hide')
          $('#edit_practice').modal('hide')
          url = '/projects/' + $('#addcommentform').attr('project_id') + template
          $.ajax
            type: 'GET',
            url: url,
            dataType: 'script'
      return false
      
    $(document).on 'click', '.js-trigger-edit-practice', ->
      $.ajax(
        type: 'GET',
        url: '/project_practices/' + $(this).attr('practice_id') + '/edit_practice'
      ).done ->
        $('#edit_practice').modal()
      return false
      
    $('#project-practicecontent').on 'click', '.js-trigger-pattern-detail', ->
      $.ajax(
        type: 'GET',
        url: '/practices/' + $(this).attr('language_id') + '/'+$(this).attr('pattern_no') + '/detail'
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
      
    $('#project-practicecontent').on 'click', '.js-trigger-project-practice-comment', ->
      $.ajax(
        type: 'GET',
        url: '/project_practices/' + $(this).attr('practice_id') + '/practice_comment'
      ).done ->
        $('#practice-comment').modal()

    
    