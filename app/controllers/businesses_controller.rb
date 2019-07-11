class BusinessesController < ApplicationController
  def index
    @businesses = Business.limit(5)
  end
end
