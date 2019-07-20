require 'rails_helper'

RSpec.feature 'user adds a business', type: :feature do
  let(:user) { Fabricate(:user) }

  scenario 'with unauthentiacted user the add a business link should be hidden' do
    visit businesses_path

    expect(page).not_to have_content('+ Add New Business')
  end

  scenario 'with authenticated user' do
    sign_in(user)

    visit businesses_path

    expect(page).to have_content('+ Add New Business')

    click_link '+ Add New Business'

    fill_in 'business_name', with: 'Hapa'
    fill_in 'business_address_1', with: '1011 Hapa Way'
    fill_in 'business_city', with: 'Boulder'
    fill_in 'business_state', with: 'Colorado'
    fill_in 'business_phone', with: '333 333 3333'
    select '$$$$', from: 'business_price'
    fill_in 'business_description', with: 'Great sushi'

    click_on 'Submit'

    expect(page).to have_content('The business has been created')
  end
end
