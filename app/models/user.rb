class User < ActiveRecord::Base
  has_secure_password
  has_many :reviews, dependent: :destroy
  has_many :businesses
  validates_presence_of :first_name, :last_name, :email
  validates_presence_of :password, on: [:new, :create, :edit_setting, :update_settings]
  validates_uniqueness_of :email, case_sensitive: false
  validate :birthday_date

  private

  def birthday_date
    return if birthday.nil?

    date = birthday.split('-')
    days_in_month = {
      '1': 31, '2': 28, '3': 31, '4': 30, '5': 31, '6': 30,
      '7': 31, '8': 31, '9': 30, '10': 31, '11': 30, '12': 31
    }

    if date.any? { |v| v.empty? } ||
                    date.size < 3 ||
                    date[2].to_i > days_in_month[date[1].to_i.to_s.to_sym]
      errors.add(:birthday)
    end
  end
end
