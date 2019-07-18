class BusinessesController < ApplicationController
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
end
