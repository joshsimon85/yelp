module ApplicationHelper
  def format_state(state)
    return '' if !state

    state.slice(0,2).upcase
  end

  def create_price_tag(price)
    return '' if price.nil?
    price_tag = ''

    price.times do |num|
      break if num == 5
      price_tag += '$'
    end

    price_tag
  end

  def create_tags(tags)
    return [] if !tags

    tags.split(',')
        .map(&:strip)
        .select { |tag| tag[0] == '@'}
        .map { |tag| tag.slice(1..-1)}
        .map(&:capitalize)
  end

  def truncate_text(text, size=250)
    return '' if !text

    if text.length > size
      "#{text.slice(0..size)} ..."
    else
      text
    end
  end

  def format_phone(phone_number)
    return '' if !phone_number

    phone_number.gsub!(/\D/, '')
    if phone_number.length == 10
      "#{phone_number.slice(0..2)}-#{phone_number.slice(3..5)}-"\
      "#{phone_number.slice(6..9)}"
    else
      "#{phone_number.slice(0)}-#{phone_number.slice(1..3)}-"\
      "#{phone_number.slice(4..6)}-#{phone_number.slice(7..10)}"
    end
  end

  def calculate_start_count(total, page_number)
    if page_number == nil || page_number.to_i == 1
      1
    else
      5 * (page_number.to_i - 1) + 1
    end
  end

  def calculate_end_count(total, page_number)
    page_number = 1 if page_number.nil?
    end_count = page_number.to_i * 5
    if end_count > total
      total
    else
      end_count
    end
  end

  def page_item_class(current_page, line_item)
    current_page = 1 if current_page.nil?
    if current_page.to_i == line_item
      'page-item active'
    else
      'page-item'
    end
  end

  def pagination_arrow_class(current_page, count, arrow)
    total_pages = (count / 5.0).ceil
    current_page = 1 if current_page.nil?
    current_page = current_page.to_i

    if current_page == 1 && arrow == 'prev'
      'page-item disabled'
    elsif current_page != 1 && arrow == 'prev'
      'page-item'
    elsif current_page == total_pages && arrow == 'next'
      'page-item disabled'
    elsif current_page == 1 && arrow == 'next'
      'page-item'
    end
  end

  def format_name(first_name, last_name)
    "#{first_name.capitalize} #{format_last_name(last_name)}"
  end

  def format_last_name(last_name)
    return '' if last_name.nil?
    return '' if last_name == ''
    "#{last_name[0].capitalize}."
  end

  def format_date(date_time)
    "#{date_time.month}-#{date_time.day}-#{date_time.year}"
  end

  def calculate_average_rating(reviews)
    return 0 if reviews.empty?
    total = reviews.map { |review| review.rating }
                   .reduce { |total, num| total + num }
    average = total / (reviews.size.to_f)
    calculate_average_rating_percentage(average)
  end

  def calculate_average_rating_percentage(average)
    (average * 20).round
  end

  def format_month_year(time)
    time.strftime("%B %Y")
  end

  def state_abb(state)
    state_map = {
      alabama: 'AL', alaska: 'AK', arizona: 'AZ', arkansas: 'AR',
      california: 'CA', colorado: 'CO', connecticut: 'CT', delaware: 'DE',
      florida: 'FL', georgia: 'GA', hawaii: 'HI', idaho: 'ID', illinois: 'IL',
      indiana: 'IN', iowa: 'IA', kansas: 'KS', kentuky: 'KY', louisiana: 'LA',
      maine: 'ME', maryland: 'MD', massachusetts: 'MA', michigan: 'MI',
      minnesota: 'MN', mississippi: 'MS', missouri: 'MO', montana: 'MT',
      nebraska: 'NE', nevada: 'NV', 'new hampshire': 'NH', 'new jersey': 'NJ',
      'new mexico': 'NM', 'new york': 'NY', 'north carolia': 'NC',
      'north dakota': 'ND', ohio: 'OH', oklahoma: 'OK', oregorn: 'OR',
      pennsylvania: 'PA', 'rhode island': 'RI', 'south carolina': 'SC',
      'south dakota': 'SD', tennessee: 'TN', texas: 'TX', utah: 'UT',
      vermont: 'VT', virginia: 'VA', washington: 'WA', 'west virginia': 'WV',
      wisconsin: 'WI', wyoming: 'WY'
    }.freeze
    state.downcase!
    state_map[state.to_sym]
  end
end
