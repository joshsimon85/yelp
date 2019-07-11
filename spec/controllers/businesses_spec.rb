require 'rails_helper'

RSpec.describe BusinessesController do
  let(:b_1) { Fabricate(:business, name: 'Z') }
  let(:b_2) { Fabricate(:business, name: 'A') }
  let(:b_3) { Fabricate(:business, name: 'B') }
  let(:b_4) { Fabricate(:business, name: 'C', state: 'Colorado') }
  let(:b_5) { Fabricate(:business, name: 'D', state: 'Colorado') }
  let(:b_6) { Fabricate(:business, name: 'E') }

  describe 'GET index' do
    it 'gets a list of the first 5 businesses in alphabetical order' do
      get :index
      expect(assigns(:businesses)).to match_array([b_2, b_3, b_4, b_5, b_1])
    end
  end
end
