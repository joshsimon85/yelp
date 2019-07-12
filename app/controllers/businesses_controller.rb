class BusinessesController < ApplicationController
  def index
    #set up paginations / offsets
    @businesses = Business.offset(6).limit(5)
    @count = Business.count
  end
end
