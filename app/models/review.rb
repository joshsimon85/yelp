class Review < ActiveRecord::Base
  validates_presence_of :body, :rating
  validates_uniqueness_of :user_id, scope: :business_id, message: 'can only create one review per business'
  belongs_to :creator, class_name: :User, foreign_key: 'user_id'
  belongs_to :business
end
