class ReviewsController < ApplicationController
  before_action :require_login, only: [:new, :create, :edit]

  def new
    @review = Review.new
    @business = Business.find(params[:business_id])
  end

  def create
    @business = Business.find(params[:business_id])
    @review = Review.new(review_params.merge(business_id: @business.id,
                                            user_id: current_user.id))
    if @review.save
      flash[:notice] = 'Your review has been submitted!'
      redirect_to business_path(params[:business_id])
    else
      flash.now[:error] = 'Your review could not be submitted'
      render :new
    end
  end

  def edit
    @review = Review.find(params[:id])
    @business = Business.find(params[:business_id])
    require_same_user(@review.creator, 'review')
  end

  def update
    @business = Business.find(params[:business_id])
    @review = Review.find(params[:id])
    require_same_user(@review.creator, 'reviews')

    if @review.update_attributes(review_params)
      flash[:notice] = 'Your review has been updated'
      redirect_to business_path(@business)
    else
      flash[:error] = 'Your review could not be submitted'
      render :edit
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :body)
  end
end
