$(document).on 'turbolinks:load', ->
  if $("body").hasClass("registrations") 
    $(document).on 'keyup', '.js-current-password',->
      if $(".js-current-password").val().length > 5
        $(".js-user-update").removeAttr("disabled")
      else
        $(".js-user-update").attr("disabled", "disabled")
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