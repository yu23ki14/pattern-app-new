$ ->
  if $("body").hasClass("registrations") 
    $(document).on 'keyup', '.js-current-password',->
      if $(".js-current-password").val().length > 5
        $(".js-user-update").removeAttr("disabled")
      else
        $(".js-user-update").attr("disabled", "disabled")
    
    $(document).on 'click', '.js-trigger-edit-password', (e) ->
      e.preventDefault
      $(".password-container").removeClass("hide")
      
    
  if $("body").hasClass("passwords")
    $(document).on 'keyup', '.js-current-password',->
      if ($(".js-current-password").val().length > 5 && $(".js-current-password-confirm").val().length > 5) && ($(".js-current-password").val() == $(".js-current-password-confirm").val())
        $(".js-user-update").removeAttr("disabled")
      else
        $(".js-user-update").attr("disabled", "disabled")
    $(document).on 'keyup', '.js-current-password-confirm',->
      if ($(".js-current-password").val().length > 5 && $(".js-current-password-confirm").val().length > 5) && ($(".js-current-password").val() == $(".js-current-password-confirm").val())
        $(".js-user-update").removeAttr("disabled")
      else
        $(".js-user-update").attr("disabled", "disabled")