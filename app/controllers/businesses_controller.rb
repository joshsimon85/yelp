class BusinessesController < ApplicationController
  def index
    @businesses = Business.get_records_by_offset(params[:page], 5)
    @count = Business.count
    @current_page = params[:page] || 1
  end

  def show
    @business = Business.find_by id: params[:id]
  end
end
