class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def authorize_admin!
    # byebug
    require_signin!

    unless current_user.admin?
      flash[:alert] = 'You must be admin to do that'
      redirect_to root_path
    end
  end

  def require_signin!
    if current_user.nil?
      flash[:alert] = 'Please log in first'
      redirect_to sign_in_path
    end
  end
  helper_method :require_signin!

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
    # byebug
  end
  helper_method :current_user

end
