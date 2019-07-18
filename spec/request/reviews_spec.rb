require 'rails_helper'

RSpec.describe 'Unauthenticated access to create reviews', type: :request do
  let!(:business) { Fabricate(:business) }

  it 'denies access to reviews#new' do
    get new_business_review_path(business.id)
    expect(response).to redirect_to sign_in_path
  end

  it 'denies access to review#create' do
    post business_reviews_path(business.id)
    expect(response).to redirect_to sign_in_path
  end
end
