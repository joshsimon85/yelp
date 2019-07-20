require 'rails_helper'

RSpec.describe 'business requests', type: :request do
  let!(:jon) { Fabricate(:user) }
  let!(:jane) { Fabricate(:user) }
  let!(:business) { Fabricate(:business, user_id: jon.id) }

  context 'authenticated user access put and delete paths' do
    context 'not belonging to the user' do
      before do
        post sign_in_path, params: {email: jane.email, password: jane.password}
      end

      it 'redirects to business path when post to edit path' do
        put business_path(business.id)
        expect(flash[:error]).to eq('You can only edit businesses you added')
        expect(response).to redirect_to business_path(business.id)
      end

      it 'redirects to business path when delete path ' do
        delete business_path(business.id)
        expect(flash[:error]).to eq('You can only delete businesses you added')
        expect(response).to redirect_to business_path(business.id)
      end
    end

    context 'belonging to the user' do
      before do
        post sign_in_path, params: {email: jon.email, password: jon.password}
      end

      it 'edits the business' do
        patch business_path(business.id), params: { 'business[description]': 'changed'}
        expect(flash[:notice]).to eq('The business has been updated')
        expect(response).to redirect_to business_path(business.id)
      end

      it 'deletes the business' do
        delete business_path(business.id)
        expect(flash[:notice]).to eq('The business has been deleted')
        expect(response).to redirect_to businesses_path
      end
    end
  end
end
