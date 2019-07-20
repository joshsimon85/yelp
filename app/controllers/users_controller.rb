class UsersController < ApplicationController
  def show
    @businesses = Business.where("lower(state) = ?", current_user.state.downcase)
                          .get_records_by_offset(params[:page])
    @count = @businesses.size
    @current_page = params[:page] || '1'
  end

  def new; end

  def create

  end
end
