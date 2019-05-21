$ ->
  window_height = $(window).height()
  
  $(".alert").delay(1300).fadeOut("normal")
  
  $(document).on 'click', '.close-modal', (e) ->
    $('.modal').modal('hide')
    return false

  $(document).on 'click', '.modal-close', (e) ->
    $('.modal').modal('hide')
    return false
    
  $('.modal-open').click ->
    target = $(this).attr('target_modal')
    $('.modal.' + target).modal()
    return false
  
  $('.js-nav-humberger').click ->
    $(".nav-container").toggleClass("is-open")
    
  $('.masonry-content img').height($('.masonry-content img').width())
  
  $('.static-masonry-container').masonry
    itemSelector: '.static-masonry-content'
  
  $grid = $('.masonry-container').masonry
    itemSelector: '.masonry-content'
    
  if $(".pagination a[rel=next]").length > 0
    msnry = $grid.data('masonry')
    
    $grid.infiniteScroll
      path: '.pagination a[rel=next]'
      hideNav: '.pagination'
      append: ".masonry-content"
      outlayer: msnry
      history: 'replace'
      prefill: false
      scrollThreshold: 100
      status: ".page-load-status"
  
  if gon.open_signup_modal == true && ( $("body").hasClass("posts") || $("body").hasClass("welcome") )
    $(".recommend-sign-up-modal").modal()