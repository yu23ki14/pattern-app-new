$(document).on "turbolinks:load", ->
  $('.masonry-container').masonry
    itemSelector: '.masonry-content'
    