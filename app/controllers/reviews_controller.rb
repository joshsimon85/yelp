class ReviewsController < ApplicationController
  before_action :require_login, only: [:new, :create]

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

  private

  def review_params
    params.require(:review).permit(:rating, :body)
  end
end
