require 'rails_helper'

RSpec.describe ReviewsController, type: :controller do
  context 'signed in user' do
    let!(:jon) { Fabricate(:user) }
    let!(:business) { Fabricate(:business, user_id: jon.id) }

    before do
      set_current_user(jon)
    end

    describe 'GET new' do
      it 'assigns @business with the business supplied in the params' do
        get :new, params: { business_id: business.id }
        expect(assigns(:business)).to eq(business)
      end

      it 'assigns @review' do
        get :new, params: { business_id: business.id }
        expect(assigns(:review)).not_to be_nil
      end
    end
  end

  context 'not signed in' do
    let!(:jon) { Fabricate(:user) }
    let!(:business) { Fabricate(:business, user_id: jon.id) }

    describe 'GET new' do
      it 'sets the flash error' do
        get :new, params: { business_id: business.id }
        expect(flash[:error]).to be_present
      end

      it 'redirects to sign in path' do
        get :new, params: { business_id: business.id }
        expect(response).to redirect_to sign_in_path
      end
    end
  end
end
