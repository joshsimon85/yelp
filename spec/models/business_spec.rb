require 'rails_helper'

RSpec.describe Business do
  it { should validate_uniqueness_of(:name).case_insensitive }
  it { should validate_presence_of :name }
  it { should validate_presence_of :address_1 }
  it { should validate_presence_of :city }
  it { should validate_presence_of :state }
  it { should validate_presence_of :phone }
  it { should validate_presence_of :description }
  it { should have_many(:reviews).dependent(:delete_all) }
  it { should belong_to :creator }

  describe 'self#qeury_by' do
    let!(:user) { Fabricate(:user) }
    let!(:hapa) { Fabricate(:business, state: 'colorado', user_id: user.id, city: 'boulder') }

    context 'state only' do
      it 'should return a list with the businesses with the same state' do
        expect(Business.query_by(nil, 'colorado')).to eq([hapa])
      end

      it 'returns a list with the businesses with the same state (case insensitive)' do
        expect(Business.query_by(nil, 'Colorado')).to eq([hapa])
      end

      it 'returns a list with the businesses that match abbreviated state' do
        expect(Business.query_by(nil, 'CO')).to eq([hapa])
      end
    end

    context 'city and state' do
      let!(:cemex) { Fabricate(:business, state: 'colorado', city: 'Superior', user_id: user.id) }

      it 'returns a list with the business that matches both city and state' do
        expect(Business.query_by(nil, 'Boulder, Colorado')).to eq([hapa])
      end
    end

    context 'city and state and categories' do
      let!(:cemex) { Fabricate(:business, state: 'colorado', city: 'Superior', user_id: user.id, tags: '@dusty, @long hours') }

      it 'returns a list with the business that matches any of the tags' do
        expect(Business.query_by('dusty', 'superior, Colorado')).to eq([cemex])
      end
    end
  end
end
