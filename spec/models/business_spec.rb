require 'rails_helper'

RSpec.describe Business do
  it { should validate_uniqueness_of :name }
  it { should validate_presence_of :name }
  it { should validate_presence_of :address_1 }
  it { should validate_presence_of :city }
  it { should validate_presence_of :state }
  it { should validate_presence_of :phone }
  it { should validate_presence_of :description }
end
