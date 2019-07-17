require 'rails_helper'

RSpec.feature 'the signin process', type: :feature do
  let!(:jon) { Fabricate(:user) }

  scenario 'signs me in' do
    visit sign_in_path

    page.fill_in 'email', with: jon.email
    page.fill_in 'password', with: jon.password

    click_button 'Log In'

    expect(page).to have_content "Welcome, #{jon.first_name.capitalize}!"
  end
end
