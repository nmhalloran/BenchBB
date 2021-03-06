class ApplicationController < ActionController::Base

  helper_method :current_user, :logged_in?

  def login(user)
    @current_user = user
    # debugger
    session[:session_token] = user.reset_session_token
  end

  def current_user
    return nil unless session[:session_token]

    @current_user ||= User.find_by_session_token(session[:session_token])
  end

  def logged_in?
    !!current_user
  end

  def require_login
    redirect to new_session_url unless logged_in?
  end

  def logout
    current_user.reset_session_token
    session[:session_token] = nil
  end
end
