class User < ActiveRecord::Base
  has_secure_password
  has_many :reviews
  has_many :businesses
  validates_presence_of :first_name, :last_name, :email, :password_digest
  validates_uniqueness_of :email, case_sensitive: false
end
