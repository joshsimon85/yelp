require 'rails_helper'

RSpec.feature 'user adds a review to a business', type: :feature do
  let(:user) { Fabricate(:user) }
  let(:hapa) { Fabricate(:business, user_id: user.id) }

  scenario 'with valid fields it should be successfully submitted' do
    sign_in(user)

    visit new_business_review_path(hapa)

    find('select#review_rating').find("option[value='5']").select_option
    fill_in 'review_body', with: 'Description of Hapa'

    click_on 'Submit'

    expect(page).to have_content('Your review has been submitted!')

  end

  scenario 'with invalid fields it should not be submitted' do
    sign_in(user)

    visit new_business_review_path(hapa)

    click_on 'Submit'

    expect(page).to have_content('2 errors')
  end

  scenario 'when a review has already been added for a business from the user' do
    sign_in(user)

    visit new_business_review_path(hapa)

    find('select#review_rating').find("option[value='5']").select_option
    fill_in 'review_body', with: 'Description of Hapa'

    click_on 'Submit'

    visit new_business_review_path(hapa)

    find('select#review_rating').find("option[value='5']").select_option
    fill_in 'review_body', with: 'Description of Hapa'

    click_on 'Submit'
    expect(page).to have_content('1 error')
  end
end
