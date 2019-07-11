class Business < ActiveRecord::Base
  default_scope { order(name: :asc) }
  validates :name, uniqueness: true
  validates_presence_of :name, :address_1, :city, :state, :phone
end
