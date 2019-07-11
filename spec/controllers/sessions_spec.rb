require 'rails_helper'
require 'support/macros'

RSpec.describe SessionsController do
  let(:user) { Fabricate(:user) }

  describe 'user logs in' do
    context 'with invalid credentials' do
      it 'renders new template' do
        post :create, params: { email: user.email, password: "#{user.password}1" }
        expect(response).to render_template :new
      end

      it 'sets the flash message' do
        post :create, params: { email: user.email, password: "#{user.password}1"}
        expect(flash[:error]).to include('There was a problem')
      end
    end

    context 'with valid credentials' do
      it 'sets the flash message' do
        post :create, params: { email: user.email, password: user.password }
        expect(flash[:success]).to include("Welcome, #{user.first_name}!")
      end

      it 'redirects to the user path' do
        post :create, params: { email: user.email, password: user.password }
        expect(response).to redirect_to(user_path(user))
      end
    end
  end

  describe 'user logs out' do
    before { set_current_user }

    it 'sets the flash message' do
      get :destroy
      expect(flash[:success]).to include('You have logged out!')
    end

    it 'sets the current user to nil' do
      get :destroy
      expect(session[:user_id]).to be_nil
    end

    it 'redirects to the root path' do
      get :destroy
      expect(response).to redirect_to root_path
    end
  end
end
