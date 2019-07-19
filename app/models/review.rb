class Review < ActiveRecord::Base
  validates_presence_of :body, :rating
  validates_uniqueness_of :user_id, scope: :business_id, message: 'can only create one review per business'
  belongs_to :creator, class_name: :User, foreign_key: 'user_id'
  belongs_to :business

  def self.get_records_by_offset(page_number, amount=5)
    if page_number.nil? || page_number.to_i == 1
      offset(0).limit(amount)
    else
      offset(5 * (page_number.to_i - 1)).limit(amount)
    end
  end
end
