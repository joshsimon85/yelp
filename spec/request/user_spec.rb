require 'rails_helper'

RSpec.describe 'User requests', type: :request do
  describe 'POST users_path' do
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

      it 'renders the new template when only the birthday day is selected' do
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
  end

  describe 'PATCH user_path' do
    context 'editing a user' do
      let!(:user) { Fabricate(:user) }
      before do
        post sign_in_path, params: { email: user.email, password: user.password }
      end

      context 'with valid inputs' do
        before do
          patch user_path(user), params: {
            'user[first_name]': 'Jon', 'user[last_name]': 'Doe',
            'user[email]': 'jon@doe.com', 'user[password]': 'password',
            'user[city]': 'Boulder', 'user[state]': 'Colorado'
          }
        end

        it 'sets the flash message' do
          expect(flash[:notice]).to eq('Your account has been updated')
        end

        it 'redirects to the current logged in users page' do
          expect(response).to redirect_to(user_path(user))
        end

        it 'updates the user' do
          expect(User.first.first_name).to eq('Jon')
        end
      end

      context 'with invalid inputs' do
        before do
          patch user_path(user), params: {
            'user[first_name]': 'Jon', 'user[last_name]': 'Doe',
            'user[email]': 'jon@doe.com', 'user[password]': 'password',
            'user[city]': 'Boulder', 'user[state]': 'Colorado',
            'birthday[(1i)]': '2014'
          }
        end

        it 'sets the flash error message' do
          expect(flash[:error]).to eq('There was an error updating your account')
        end

        it 'renders the edit template' do
          expect(response).to render_template(:edit)
        end

        it 'shows an invalid birthday error' do
          expect(response.body).to include('Birthday is invalid')
        end

        it 'does not update the user' do
          expect(User.first.first_name).to eq(user.first_name)
        end
      end

      context 'a user editing another users account' do
        let!(:user_2) { Fabricate(:user) }
        before do
          patch user_path(user_2), params: {
            'user[first_name]': 'Jon', 'user[last_name]': 'Doe',
            'user[email]': 'jon@doe.com', 'user[password]': 'password',
            'user[city]': 'Boulder', 'user[state]': 'Colorado',
          }
        end

        it 'sets the flash error message' do
          expect(flash[:error]).to eq('You can not edit an account that does not belong to you')
        end

        it 'redirects the the current users sign in path' do
          expect(response).to redirect_to(user_path(user))
        end

        it 'does not update the user' do
          expect(User.find(user_2.id)).to eq(user_2)
        end
      end
    end
  end

  describe 'POST user_path :destroy' do
    let!(:user) { Fabricate(:user) }
    let!(:business) { Fabricate(:business, user_id: user.id) }
    let!(:review) { Fabricate(:review, business_id: business.id, user_id: user.id) }

    context 'signed in user deletes his/her account' do
      before do
        post sign_in_path, params: { email: user.email, password: user.password }
        delete user_path(user)
      end

      it 'sets the flash notice' do
        expect(flash[:notice]).to eq('Your account has been deleted')
      end

      it 'redirects to the root path' do
        expect(response).to redirect_to root_path
      end

      it 'deletes the user and user reviews from the db' do
        expect(User.count).to eq(0)
      end

      it 'does not delete the businesses the user created' do
        expect(Business.count).to eq(1)
      end

      it 'does delete the user reviews' do
        expect(Review.count).to eq(0)
      end
    end

    context 'signed in user deletes anothers account' do
      let!(:user_2) { Fabricate(:user) }
      before do
        post sign_in_path, params: { email: user.email, password: user.password }
        delete user_path(user_2)
      end

      it 'sets the flash error message' do
        expect(flash[:error]).to eq('You can not delete an account that does not belong to you')
      end

      it 'redirects to the current users page' do
        expect(response).to redirect_to(user_path(user))
      end

      it 'does not delete the account' do
        expect(User.find(user_2.id)).to eq(user_2)
      end
    end

    context 'unauthenticated user deletes an account' do
      before do
        delete user_path(user)
      end

      it 'sets the error flash message' do
        expect(flash[:error]).to eq('You must be logged in to do that')
      end

      it 'redirects to the sign in path' do
        expect(response).to redirect_to sign_in_path
      end

      it 'does not delete the user' do
        expect(User.count).to eq(1)
      end
    end
  end
end
