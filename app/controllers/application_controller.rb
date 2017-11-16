class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_user
  before_action :backhome
  
  private
    def backhome
      if controller_name == "practices" || controller_name == "recommends"
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
end
