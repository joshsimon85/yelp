require 'rails_helper'

RSpec.feature 'user adds a review to a business', type: :feature do
  let(:jon) { Fabricate(:user) }
  let(:jane) { Fabricate(:user) }
  let(:hapa) { Fabricate(:business, user_id: jon.id) }
  let(:jon_review) { Fabricate(:review, business_id: hapa.id, user_id: jon.id) }
  let(:jane_review) { Fabricate(:review, business_id: hapa.id, user_id: jane.id) }

  scenario 'with valid fields it should be successfully edited' do
    sign_in(jon)

    visit edit_business_review_path(hapa, jon_review)

    fill_in 'review_body', with: 'Another review'

    click_on 'Submit'

    expect(page).to have_content('Your review has been updated')

  end

  scenario 'with invalid fields it should not be submitted' do
    sign_in(jon)

    visit edit_business_review_path(hapa, jon_review)

    fill_in 'review_body', with: ''

    click_on 'Submit'

    expect(page).to have_content('Your review could not be submitted')
  end

  scenario 'user edits a review that does not belong to them' do
    sign_in(jon)

    visit edit_business_review_path(hapa, jane_review)

    expect(page).to have_content('You can only edit your own reviews!')
  end
end
