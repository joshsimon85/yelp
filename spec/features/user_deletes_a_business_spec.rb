require 'rails_helper'

RSpec.feature 'user deletes a business', type: :feature do
  let(:jon) { Fabricate(:user) }

  before do
    business = Fabricate(:business, user_id: jon.id)
  end

  scenario 'authenticated user deletes a business they created' do
    sign_in(jon)

    click_on('all-businesses-link')

    #find(:xpath, '//*[@class=".businesses"]/li' '.businesses li:first-of-type h2 a:fist-of-type')

  end
end
