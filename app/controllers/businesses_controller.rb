class BusinessesController < ApplicationController
  before_action :require_login, only: [:new, :create, :edit, :update]

  def index
    @businesses = Business.get_records_by_offset(params[:page], 5)
    @count = Business.count
    @current_page = params[:page] || '1'
  end

  def show
    @business = Business.find_by id: params[:id]
    @current_page = params[:page] || '1'
    @reviews = get_reviews_by_offset(@business.reviews, @current_page)
    @count = @business.reviews.size
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

  def query
    @category = params[:category]
    @location = params[:location]
    @current_page = params[:page] || '1'
    @businesses = Business.query_by(@category, @location, @current_page, false)
    @count = Business.query_by(@category, @location, @current_page)
    @terms = "#{@category} #{@location}".strip
  end

  private

  def get_reviews_by_offset(reviews, page_number, amount=5)
    if page_number.nil? || page_number.to_i == 1
      reviews.offset(0).limit(amount)
    else
      reviews.offset(5 * (page_number.to_i - 1)).limit(amount)
    end
  end

  def business_params
    params.require(:business).permit!
  end
end
