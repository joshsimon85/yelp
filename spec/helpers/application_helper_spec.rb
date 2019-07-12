require 'rails_helper'

describe ApplicationHelper do
  describe '#format_state' do
    it 'returns the two first two letters of the state' do
      expect(helper.format_state('Colorado')).to eq('CO')
    end

    it 'returns an upcase abbreviation of the state' do
      expect(helper.format_state('colorado')).to eq('CO')
    end

    it 'returns an empty string if no state is provided' do
      expect(helper.format_state(nil)).to eq('')
    end
  end

  describe '#create_price_tag' do
    it 'returns $ if the value of price is  1' do
      expect(helper.create_price_tag(1)).to eq('$')
    end

    it 'returns an empty string if the price is 0' do
      expect(helper.create_price_tag(0)).to eq('')
    end

    it 'returns an empty string if the price is less than 0' do
      expect(helper.create_price_tag(-1)).to eq('')
    end

    it 'returns $$$$$ if the price is greater than 5' do
      expect(helper.create_price_tag(6)).to eq('$$$$$')
    end
  end

  describe '#create_tags' do
    it 'returns an empty list if there are no tags' do
      expect(helper.create_tags(nil)).to eq([])
    end

    it 'returns a list with one lowercase tag without and @' do
      expect(helper.create_tags('@taG')).to eq(['Tag'])
    end

    it 'returns a list of two tags' do
      expect(helper.create_tags('@Tag, @tAg2')).to eq(['Tag', 'Tag2'])
    end

    it 'returns one tag if there are tags without @ prepended' do
      expect(helper.create_tags('@tag, tag2, tag3')).to eq(['Tag'])
    end

    it 'returns tags that include space separated words' do
      expect(helper.create_tags('@tag, @tag two')).to eq(['Tag', 'Tag two'])
    end
  end

  describe '#truncate_text' do
    it 'returns an empty string if there is not any text' do
      expect(helper.truncate_text(nil)).to eq('')
    end

    it 'returns the entire text if it is less than 33 chars' do
      text = Faker::Lorem.characters(32)
      expect(helper.truncate_text(text)).to eq(text)
    end

    it 'returns 33 characters if the text is longer than 250 followed by ...' do
      text = Faker::Lorem.characters(260)
      expect(helper.truncate_text(text)).to eq("#{text.slice(0..250)} ...")
    end

    it 'returns 50 characters if the text is longer than 50 chars and size is set to 50' do
      text = Faker::Lorem.characters(100)
      expect(helper.truncate_text(text, 50)).to eq("#{text.slice(0..50)} ...")
    end
  end

  describe '#format_phone' do
    it 'returns an empty string if the phone number is nil' do
      expect(helper.format_phone(nil)).to eq('')
    end

    context 'when there are 10 digits' do
      it 'returns ###-###-#### format' do
        expect(helper.format_phone('111-222-3333')).to eq('111-222-3333')
      end

      it 'returns ###-###-#### format when it is just digits' do
        expect(helper.format_phone('1112223333')).to eq('111-222-3333')
      end

      it 'returns ###-###-#### when non digits are encountered' do
        expect(helper.format_phone('111a222./333i3')).to eq('111-222-3333')
      end
    end

    context 'where there are 11 or more digits' do
      it 'returns #-###-###-#### when it has 11 digits' do
        expect(helper.format_phone('11112223333')).to eq('1-111-222-3333')
      end

      it 'returns #-###-###-#### when it has more than 11 digits' do
        expect(helper.format_phone('11112223333444555')).to eq('1-111-222-3333')
      end
    end
  end
end
