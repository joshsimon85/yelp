class Review < ActiveRecord::Base
  validates_presence_of :body, :rating
  belongs_to :creator, class_name: :User, foreign_key: 'user_id'
  belongs_to :business
end
