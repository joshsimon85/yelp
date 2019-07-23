require 'rails_helper'

RSpec.describe User do
  it { should have_secure_password }
  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }
  it { should validate_presence_of :email }
  it { should validate_presence_of :password }
  it { should validate_uniqueness_of(:email).case_insensitive }
  it { should have_many(:reviews).dependent(:destroy) }
  it { should have_many :businesses }
end
