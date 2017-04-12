class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :require_login

  class NotAuthorized < StandardError
  end
  rescue_from NotAuthorized, with: :not_authorized

  def current_user
    return unless session[:user_id]
    @current_user ||= User.find(session[:user_id])
  end

  private

  # User not authorized
  def not_authorized(exception)
    respond_to do |format|
      format.html {
        flash[:error] = exception.to_s
        redirect_to login_path
      }
      format.js {
        head :forbidden
      }
    end
  end

  def not_authenticated
    flash[:notice] = 'Oops, seems you are not logged in.'
    redirect_to login_path
  end

  # Check if user is logged in and has role
  def is?(role)
    logged_in? && current_user.is?(role)
  end
  
  # Check if user role is admin
  def only_authorize_admin!
    authorize!(is?(:admin))
  end

  def authorize!(condition,
                 msg = "Oops, seems you don't have permission to do that.")
    unless condition
      raise NotAuthorized, msg
    end
  end

end
