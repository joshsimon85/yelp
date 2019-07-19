class ApplicationController < ActionController::Base
  helper_method :logged_in?, :current_user, :same_user?

  def logged_in?
    !!current_user
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def require_login
    unless logged_in?
      flash[:error] = 'You must be logged in to do that'
      redirect_to sign_in_path
    end
  end

  def same_user?(user)
    return false if current_user.nil?
    current_user.id == user.id
  end

  def require_same_user(user, type)
    unless same_user?(user)
      flash[:error] = "You can only edit/delete a #{type} you created!"
      redirect_to businesses_path
    end
  end
end
