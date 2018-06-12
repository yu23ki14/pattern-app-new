/*modalplugin*/

(function( $ ) {
  var methods = {
    init : function() {
      $("body").css("min-height", $(window).innerHeight() + "px");
      this.addClass("in");
      this.attr('aria-hidden', 'false');
      this.css('display', 'block');
      if (this.children(".modal-backdrop").length == 0){
        this.prepend('<div class="modal-backdrop in" style="height: 100%">');
      }
      this.parents("body").addClass("modal-open");
      var modal_margin = ($(window).innerHeight() - $(this).children(".modal-container").height()) / 2;
      console.log(modal_margin);
      var modal_position = $(document).innerHeight() - window.pageYOffset - modal_margin;
      this.children(".modal-container").css("top", "-" + modal_position + "px");
    },
    show : function() {
      $("body").css("min-height", $(window).innerHeight() + "px");
      this.addClass("in");
      this.attr('aria-hidden', 'false');
      this.css('display', 'block');
      if (this.children(".modal-backdrop").length == 0){
        this.prepend('<div class="modal-backdrop in" style="height: 100%">');
      }
      this.parents("body").addClass("modal-open");
      var modal_margin = ($(window).innerHeight() - $(this).children(".modal-container").height()) / 2;
      console.log(modal_margin);
      var modal_position = $(document).innerHeight() - window.pageYOffset - modal_margin;
      this.children(".modal-container").css("top", "-" + modal_position + "px");
    },
    hide : function() {
      
      this.removeClass("in");
      this.attr('aria-hidden', 'true');
      this.parents("body").removeClass("modal-open");
      this.css('display', 'none');
      
    },
    update : function() {
    }
  };
  
  $.fn.modal = function(method) {
    if ( methods[method] ) {
      return methods[ method ].apply( this, Array.prototype.slice.call( arguments, 1 ));
    } else if ( typeof method === 'object' || ! method ) {
      return methods.init.apply( this, arguments );
    } else {
      $.error( 'Method ' +  method + ' does not exist on jQuery.tooltip' );
    }
  };
  
})( jQuery );