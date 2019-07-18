require 'rails_helper'

RSpec.describe BusinessesController do
  let!(:jon) { Fabricate(:user) }
  let!(:b_1) { Fabricate(:business, name: 'Z', user_id: jon.id) }
  let!(:b_2) { Fabricate(:business, name: 'A', user_id: jon.id) }
  let!(:b_3) { Fabricate(:business, name: 'B', user_id: jon.id) }
  let!(:b_4) { Fabricate(:business, name: 'C', state: 'Colorado', user_id: jon.id) }
  let!(:b_5) { Fabricate(:business, name: 'D', state: 'Colorado', user_id: jon.id) }
  let!(:b_6) { Fabricate(:business, name: 'E', user_id: jon.id) }

  describe 'GET index' do
    it 'gets a list of the first 5 businesses in alphabetical order' do
      get :index
      expect(assigns(:businesses)).to eq([b_2, b_3, b_4, b_5, b_6])
    end

    it 'assigns @count' do
      get :index
      expect(assigns(:count)).to eq(6)
    end

    it 'assigns @current_page to 1 when no page query string is given' do
      get :index
      expect(assigns(:current_page)).to eq('1')
    end

    it 'assigns @current_page to 2 when a page query string of 2 is given' do
      get :index, params: {page: 2}
      expect(assigns(:current_page)).to eq('2')
    end
  end

  describe 'GET show' do
    it 'assigns @business' do
      get :show, params: { id: "#{b_1.id }" }
      expect(assigns(:business)).to eq(b_1)
    end
  end
end
