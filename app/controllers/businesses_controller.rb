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
      redirect_to businesses_path
    else
      flash.now[:error] = 'The business could not be submitted'
      render :new
    end
  end

  def edit
    @business = Business.find(params[:id])
    unless same_user?(@business.creator)
      flash[:error] = 'You can only edit businesses you added'
      redirect_to business_path(@business)
    end
  end

  def update
    @business = Business.find(params[:id])
    if same_user?(@business.creator)
      if @business.update_attributes(business_params)
        flash[:notice] = 'The business has been updated'
        redirect_to business_path(@business)
      else
        flash.now[:error] = 'The business could not be updated'
        render :edit
      end
    else
      flash[:error] = 'You can only edit businesses you added'
      redirect_to business_path(@business)
    end
  end

  def destroy
    business = Business.find(params[:id])
    if same_user?(business.creator)
      flash[:notice] = 'The business has been deleted'
      redirect_to businesses_path
      business.destroy
    else
      flash[:error] = 'You can only delete businesses you added'
      redirect_to business_path(business)
    end
  end

  private

  def business_params
    params.require(:business).permit!
  end
end
