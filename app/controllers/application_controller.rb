class ApplicationController < ActionController::Base
  before_filter :require_login
  helper_method :current_user
  def require_login
	unless logged_in?
		flash[:error]=t(:"You must be logged in to continue")
		redirect_to "/"
	end
  end
  def logged_in?
	!!current_user
  end
  def current_user
    @_current_user ||= session[:current_user_id] &&
      User.find_by_id(session[:current_user_id])
  end
  protect_from_forgery
end
