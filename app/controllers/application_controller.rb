class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_subdomain
  before_action :set_user
  before_action :backhome
  before_action :set_locale
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :sign_up_modal
  
  def after_sign_in_path_for(resource)
    if @subdomain.blank?
      practices_path
    else
      presentation_root_path
    end
  end
  
  private
    def set_subdomain
      if Rails.env.production?
        @subdomain = request.subdomain.blank? ? false : true 
      else
        @subdomain = request.subdomain.length < 20 ? false: true
      end
    end
  
    def backhome
      if @subdomain || controller_name == "welcome" || controller_name == "registrations" || controller_name == "sessions" || controller_name == "alexa_talks" || controller_name == "passwords"
        return
      else
        if !user_signed_in? 
          redirect_to root_path, notice: 'ログインしてください。'
        end
      end
    end
    
    def set_user
      if user_signed_in?
        @user = User.find(current_user.id)
      end
    end
    
    def set_locale
      if user_signed_in?
        I18n.locale = @user.locale
        gon.locale = I18n.locale
      end
    end
    
    def sign_up_modal
      if !user_signed_in? && @subdomain
        visited_time = cookies["visit_time"].to_i
        if visited_time > 4
          gon.open_signup_modal = true
        else
          visited_time += 1
          cookies.permanent["visit_time"] = visited_time
          gon.open_signup_modal = false
        end
      end
    end

  protected

    def configure_permitted_parameters
      added_attrs = [ :name, :locale, :email, :password, :password_confirmation, :monday_remind]
      devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
      devise_parameter_sanitizer.permit :account_update, keys: added_attrs
      devise_parameter_sanitizer.permit :sign_in, keys: added_attrs
    end
end
