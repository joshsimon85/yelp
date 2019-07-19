class Business < ActiveRecord::Base
  default_scope { order(name: :asc) }
  has_many :reviews, dependent: :delete_all
  belongs_to :creator, class_name: 'User', foreign_key: 'user_id'
  validates_uniqueness_of :name, case_sensitive: false
  validates_presence_of :name, :address_1, :city, :state, :phone, :description

  def self.get_records_by_offset(page_number, amount=5)
    if page_number.nil? || page_number.to_i == 1
      offset(0).limit(amount)
    else
      offset(5 * (page_number.to_i - 1)).limit(amount)
    end
  end
end
