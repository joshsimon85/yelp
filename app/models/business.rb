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

  def self.query_by(category, location, page_number, count=true, amount=5)
    city_state = location.split(',')
    state = city_state[1].downcase.strip if city_state.size == 2
    city = city_state[0].downcase.strip unless city_state.empty?

    if !category.empty? && location
      self.find_by_cat_and_location(category, city, state, page_number, count, amount)
    elsif city_state.size == 2
      self.find_by_location(city, state, page_number, count, amount)
    else
      self.find_by_city_or_state(location.downcase.strip, page_number, count)
    end
  end

  private

  def self.find_by_city_or_state(location, page_number, count)
    if count
      where("lower(city) LIKE ? OR lower(state) LIKE ?", "%#{location.downcase.strip}%", "%#{location.downcase.strip}%").count
    else
      if page_number.nil? || page_number.to_i == 1
        where("lower(city) LIKE ? OR lower(state) LIKE ?", "%#{location.downcase.strip}%", "%#{location.downcase.strip}%").offset(0).limit(5)
      else
        where("lower(city) LIKE ? OR lower(state) LIKE ?", "%#{location.downcase.strip}%", "%#{location.downcase.strip}%").offset(5 * (page_number.to_i - 1)).limit(amount)
      end
    end
  end

  def self.find_by_location(city, state, page_number, count, amount)
    if count
      where("lower(city) LIKE ? AND lower(state) LIKE ?", "%#{city}%", "%#{state}%").count
    else
      if page_number.nil? || page_number.to_i == 1
        where("lower(city) LIKE ? AND lower(state) LIKE ?", "%#{city}%", "%#{state}%").offset(0).limit(amount)
      else
        where("lower(city) LIKE ? AND lower(state) LIKE ?", "%#{city}%", "%#{state}%").offset(5 * (page_number.to_i - 1)).limit(amount)
      end
    end
  end

  def self.find_by_cat_and_location(category, city, state, page_number, count, amount)
    if count
      where("lower(city) LIKE ? AND lower(state) LIKE ? AND lower(tags) LIKE ?", "%#{city}%", "%#{state}%", "%#{category.downcase.strip}%").count
    else
      if page_number.nil? || page_number.to_i == 1
        where("lower(city) LIKE ? AND lower(state) LIKE ? AND lower(tags) LIKE ?", "%#{city}%", "%#{state}%", "%#{category.downcase.strip}%").offset(0).limit(amount)
      else
        where("lower(city) LIKE ? AND lower(state) LIKE ? AND lower(tags) LIKE ?", "%#{city}%", "%#{state}%", "%#{category.downcase.strip}%").offset(5 * (page_number.to_i - 1)).limit(amount)
      end
    end
  end
end
