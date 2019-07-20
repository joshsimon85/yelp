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

    unless same_user?(@review.creator)
      flash[:error] = 'You can only edit reivews you created'
      redirect_to business_path(@business)
    end
  end

  def update
    @business = Business.find(params[:business_id])
    @review = Review.find(params[:id])
    if same_user?(@review.creator)
      if @review.update_attributes(review_params)
        flash[:notice] = 'Your review has been updated'
        redirect_to business_path(@business)
      else
        flash[:error] = 'Your review could not be submitted'
        render :edit
      end
    else
      flash[:error] = 'You can only edit reviews you created'
      redirect_to business_path(@business)
    end
  end

  def destroy
    review = Review.find_by(business_id: params[:business_id], id: params[:id])
    if same_user?(review.creator)
      review.destroy
      flash[:notice] = 'Your review has been deleted'
      redirect_to business_path(params[:business_id])
    else
      flash[:error] = 'You can only delete reviews you created'
      redirect_to business_path(params[:business_id])
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :body)
  end
end
