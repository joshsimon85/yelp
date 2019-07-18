require 'rails_helper'

RSpec.describe Review do
  it { should belong_to :creator }
  it { should belong_to :business }
  it { should validate_presence_of :body }
  it { should validate_presence_of :rating }
  it { should validate_uniqueness_of(:user_id).scoped_to(:business_id).with_message("can only create one review per business")}
end
