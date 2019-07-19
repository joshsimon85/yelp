class BusinessesController < ApplicationController
  before_action :require_login, only: [:new, :create, :edit, :update]

  def index
    @businesses = Business.get_records_by_offset(params[:page], 5)
    @count = Business.count
    @current_page = params[:page] || '1'
  end

  def show
    @business = Business.find_by id: params[:id]
    @reviews = @business.reviews.limit(5)
    @count = @business.reviews.size
    @current_page = params[:page] || '1'
  end

  def new
    @business = Business.new
  end

  def create
    @business = Business.new(business_params.merge(user_id: current_user.id))
    if @business.save
      flash[:notice] = 'The business has been created'
      redirect_to user_path(current_user.id)
    else
      flash.now[:error] = 'The business could not be submitted'
      render :new
    end
  end

  def edit
    @business = Business.find(params[:id])
    require_same_user(@business.creator, 'business')
  end

  def update
    @business = Business.find(params[:id])
    require_same_user(@business.creator, 'business')
    if @business.update_attributes(business_params)
      flash[:notice] = 'The business has been updated'
      redirect_to user_path(current_user)
    else
      flash.now[:error] = 'The business could not be updated'
      render :edit
    end
  end

  def destroy
    @business = Business.find(params[:id]).destroy
    require_same_user(@business.creator, 'business')
    flash[:notice] = 'The business has been deleted'
    redirect_to businesses_path
  end

  private

  def business_params
    params.require(:business).permit!
  end
end
