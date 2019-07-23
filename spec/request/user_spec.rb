require 'rails_helper'

RSpec.describe 'User requests', type: :request do
  context 'creating a user'
    context 'valid inputs' do
      it 'creates a new user without birthday' do
        post users_path, params: {
          'user[first_name]': 'Jon', 'user[last_name]': 'Doe',
          'user[email]': 'jon@doe.com', 'user[password]': 'password',
          'user[city]': 'Boulder', 'user[state]': 'Colorado'
        }
        expect(response).to redirect_to user_path(current_user.id)
      end

      it 'creates a new user with valid birthday' do
        post users_path, params: {
          'user[first_name]': 'Jon', 'user[last_name]': 'Doe',
          'user[email]': 'jon@doe.com', 'user[password]': 'password',
          'user[city]': 'Boulder', 'user[state]': 'Colorado',
          'birthday[(2i)]': '1', 'birthday[(3i)]': '1', 'birthday[(1i)]': '2014'
        }
        expect(response).to redirect_to user_path(current_user.id)
      end

      it 'sets a successful flash message' do
        post users_path, params: {
          'user[first_name]': 'Jon', 'user[last_name]': 'Doe',
          'user[email]': 'jon@doe.com', 'user[password]': 'password',
          'user[city]': 'Boulder', 'user[state]': 'Colorado'
        }
        expect(flash[:notice]).to eq('Your account has been created')
      end
    end

    context 'with invalid inputs' do
      it 'sets the flash error' do
        post users_path, params: { 'user[first_name]': 'Jon' }
        expect(flash[:error]).to eq('There was an error creating your account')
      end

      it 'renders the new template' do
        post users_path, params: { 'user[first_name]': 'Jon' }
        expect(response).to render_template :new
      end

      it 'renders the new template when only the birthday month is selected' do
        post users_path, params: {
          'user[first_name]': 'Jon', 'user[last_name]': 'Doe',
          'user[email]': 'jon@doe.com', 'user[password]': 'password',
          'user[city]': 'Boulder', 'user[state]': 'Colorado',
          'birthday[(2i)]': '1'
        }
        expect(response.body).to include('Birthday is invalid')
      end

      it 'reders the new template when only the birthday day is selected' do
        post users_path, params: {
          'user[first_name]': 'Jon', 'user[last_name]': 'Doe',
          'user[email]': 'jon@doe.com', 'user[password]': 'password',
          'user[city]': 'Boulder', 'user[state]': 'Colorado',
          'birthday[(3i)]': '1'
        }
        expect(response.body).to include('Birthday is invalid')
      end

      it 'renders the new template when only the birthday year is selected' do
        post users_path, params: {
          'user[first_name]': 'Jon', 'user[last_name]': 'Doe',
          'user[email]': 'jon@doe.com', 'user[password]': 'password',
          'user[city]': 'Boulder', 'user[state]': 'Colorado',
          'birthday[(1i)]': '2014'
        }
        expect(response.body).to include('Birthday is invalid')
      end
    end

  context 'editing a user' do
    
  end
end
