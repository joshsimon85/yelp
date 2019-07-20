require 'rails_helper'

RSpec.feature 'deletes a review from a business', type: :feature do
  let(:jon) { Fabricate(:user) }
  let(:jane) { Fabricate(:user) }
  let(:hapa) { Fabricate(:business, user_id: jon.id) }
  let(:jon_review) { Fabricate(:review, business_id: hapa.id, user_id: jon.id) }
  let(:jane_review) { Fabricate(:review, business_id: hapa.id, user_id: jane.id) }

  scenario 'the review should be deleted if the same user created it' do
    sign_in(jon)

    visit edit_business_review_path(hapa, jon_review)

    find('#delete-link', visible: false).click

    expect(page).to have_content('Your review has been deleted')
  end

  scenario 'the review should not be deleted if the review was not created by the user' do
    sign_in(jon)

    visit edit_business_review_path(hapa, jane_review)

    expect(page).to have_content('You can only edit reivews you created')
  end
end
