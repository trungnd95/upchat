class ApplicationController < ActionController::Base
  include SessionsHelper
  protect_from_forgery with: :exception
  helper_method :logged_in_user

  private
  def logged_in_user
    unless logged_in?
      flash[:info] = "You must login to access this page!"
      redirect_to new_session_path
    end
  end

end
