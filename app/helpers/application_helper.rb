module ApplicationHelper
  def format_state(state)
    return '' if !state

    state.slice(0,2).upcase
  end

  def create_price_tag(price)
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
end
