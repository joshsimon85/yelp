class UsersController < ApplicationController
  def show
    @user = User.find(params[:id]) || User.find(current_user.id)
    @reviews = @user.reviews
    @businesses = Business.where("lower(state) = ?", current_user.state.downcase)
                          .get_records_by_offset(params[:page])
    @count = @businesses.size
    @current_page = params[:page] || '1'
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params.merge(birthday: format_birthday(params[:birthday])))

    if @user.save
      flash[:notice] = 'Your account has been created'
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      flash.now[:error] = 'There was an error creating your account'
      @user.birthday = nil if @user.errors.messages.include?(:birthday)
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
    unless same_user?(@user)
      if logged_in?
        flash[:error] = 'You can not edit an account that does not belong to you'
        redirect_to user_path(current_user.id)
      else
        flash[:error] = 'You must be logged in to do that'
        redirect_to sign_in_path
      end
      return
    end
  end

  def update
    @user = User.find(params[:id])

    unless same_user?(@user)
      if logged_in?
        flash[:error] = 'You can not edit an account that does not belong to you'
        redirect_to user_path(current_user.id)
      else
        flash[:error] = 'You must be logged in to do that'
        redirect_to sign_in_path
      end
      return
    end

    @user.update(user_params.merge(birthday: format_birthday(params[:birthday])))
    if @user.save
      flash[:notice] = 'Your account has been updated'
      redirect_to user_path(@user)
    else
      flash.now[:error] = 'There was an error updating your account'
      @user.birthday = nil if @user.errors.messages.include?(:birthday)
      render :edit
    end
  end

  def edit_settings
    @user = User.find(params[:id])

    unless same_user?(@user)
      if logged_in?
        flash[:error] = 'You can not edit account settings on an account that does not belong to you'
        redirect_to user_path(current_user.id)
      else
        flash[:error] = 'You must be logged in to do that'
        redirect_to sign_in_path
      end
      return
    end
  end

  def update_settings
    @user = User.find(params[:id])

    unless same_user?(@user)
      if logged_in?
        flash[:error] = 'You can not delete an account that does not belong to you'
        redirect_to user_path(current_user.id)
      else
        flash[:error] = 'You must be logged in to do that'
        redirect_to sign_in_path
      end
      return
    end

    if !@user.authenticate(params[:c_pass])
      flash.now[:error] = 'There was an error with your current password'
      render :edit
    elsif params[:new_pass].empty? && params[:v_pass].empty?
      flash.now[:error] = "Your new password can't be blank"
      render :edit
    elsif params[:new_pass] != params[:v_pass]
      flash.now[:error] = 'Your new passwords must match'
      render :edit
    else
      flash[:notice] = 'Your password has been updated'
      @user.update_attribute(:password, params[:new_pass])
      redirect_to user_path(@user)
    end
  end

  def destroy
    @user = User.find(params[:id])

    unless same_user?(@user)
      if logged_in?
        flash[:error] = 'You can not delete an account that does not belong to you'
        redirect_to user_path(current_user.id)
      else
        flash[:error] = 'You must be logged in to do that'
        redirect_to sign_in_path
      end
      return
    end

    @user.destroy
    flash[:notice] = 'Your account has been deleted'
    session[:user_id] = nil
    redirect_to :root
  end

  private

  def format_birthday(date)
    return nil if date.nil?
    return nil if date.values.all? { |value| value.empty? }
    "#{date['(1i)']}-#{date['(2i)']}-#{date['(3i)']}"
  end

  def user_params
    params.require(:user).permit!
  end
end
