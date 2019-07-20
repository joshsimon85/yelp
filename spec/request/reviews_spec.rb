require 'rails_helper'

RSpec.describe 'review requests', type: :request do
  let!(:jon) { Fabricate(:user) }
  let!(:jane) { Fabricate(:user) }
  let!(:business) { Fabricate(:business, user_id: jon.id) }
  let!(:jon_review) { Fabricate(:review, user_id: jon.id, business_id: business.id) }
  let!(:jane_review) { Fabricate(:review, user_id: jane.id, business_id: business.id) }

  context 'unauthenticated access' do
    it 'denies access to reviews#new' do
      get new_business_review_path(business.id)
      expect(response).to redirect_to sign_in_path
    end

    it 'denies access to review#create' do
      post business_reviews_path(business.id)
      expect(response).to redirect_to sign_in_path
    end

    it 'denies access to reviews#destory' do
      delete business_review_path(business.id, jane_review.id)
      expect(flash[:error]).to eq('You can only delete reviews you created')
      expect(response).to redirect_to business_path(business.id)
    end
  end

  context 'authenticated user access' do
    before do
      post sign_in_path, params: {email: jon.email, password: jon.password}
    end

    context 'signed in user is the same as the review creator' do
      it 'updates the review' do
        patch business_review_path(business, jon_review), params: { "review[body]": 'Changed' }
        expect(flash[:notice]).to eq('Your review has been updated')
        expect(response).to redirect_to business_path(business)
      end

      it 'deletes the review' do
        delete business_review_path(business, jon_review)
        expect(flash[:notice]).to eq('Your review has been deleted')
        expect(response).to redirect_to business_path(business)
      end
    end

    context 'signed in user is different than the review creator' do
      it 'does not update the review' do
        patch business_review_path(business, jane_review), params: { "review[body]": 'Changed' }
        expect(flash[:error]).to eq('You can only edit reviews you created')
        expect(response).to redirect_to business_path(business)
      end

      it 'does not delete the review' do
        delete business_review_path(business, jane_review)
        expect(flash[:error]).to eq('You can only delete reviews you created')
        expect(response).to redirect_to business_path(business)
      end
    end
  end
end
