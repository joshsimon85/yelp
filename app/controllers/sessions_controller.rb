class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:email]

    if user && user.authenticate(params[:password])
      flash[:success] = "Welcome, #{user.first_name}!"
      session[:user_id] = user.id
      redirect_to user_path(user)
    else
      flash.now[:error] = 'There was a problem with your email or password'
      render :new
    end
  end

  def destroy
    flash[:success] = 'You have logged out!'
    session.delete(:user_id)
    redirect_to root_path
  end
end
