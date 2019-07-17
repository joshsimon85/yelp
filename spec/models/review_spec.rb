require 'rails_helper'

RSpec.describe Review do
  it { should belong_to :creator }
  it { should belong_to :business }
  it { should validate_presence_of :body }
  it { should validate_presence_of :rating }
end
