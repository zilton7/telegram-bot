require_relative '../lib/process_data'
require_relative '../lib/bot'

processor = DataProcessor.new('12', '20')

describe DataProcessor do
  describe '#gather_data' do
    it 'Returns array of parsed data' do
      expect(processor.gather_data).to be_a(String)
    end
  end

  describe '#parse_data' do
    it 'Returns array of parsed data' do
      str = '<event date="1974-12-20" content="content"/>'
      expect(processor.parse_data(str)).to be_a(Array)
    end
  end

  describe '#parse_data' do
    it 'Returns \'nothing found\' if parsed data has no xml elements' do
      expect(processor.parse_data('whatever string')).to eq('nothing found')
    end
  end

  describe '#format_data' do
    it 'Returns array of parsed data' do
      output_example = "Here are the famous people born on the same day as you: \n\n1987-12-20 --- Zil Norvilis a"\
                        "n amazing web developer\n"
      data_arr = [{ date: '1987-12-20', content: 'Zil Norvilis an amazing web developer' }]
      expect(processor.format_data(data_arr)).to eq(output_example)
    end
  end

  describe '#format_data' do
    it 'Returns nil if parsed data has nil' do
      data_arr = [{ date: '1987-12-20' }]
      expect(processor.format_data(data_arr)).to eq(nil)
    end
  end
end

bot = Bot.new('1738382169:AAHcVo5q0ChpInYEaMs0BJKvv_bIhkU3BJY')

describe Bot do
  describe '#extract_month' do
    it 'Returns month from date string' do
      expect(bot.extract_month('1997-12-02')).to eq('12')
    end
  end

  describe '#extract_month' do
    it 'Returns nil if invalid month from date string' do
      expect(bot.extract_month('1997-1-02')).to eq(nil)
    end
  end

  describe '#extract_day' do
    it 'Returns day from date string' do
      expect(bot.extract_day('1997-12-02')).to eq('02')
    end
  end

  describe '#extract_day' do
    it 'Returns nil if invalid day from date string' do
      expect(bot.extract_day('1997-12-0')).to eq(nil)
    end
  end

  describe '#valid_date?' do
    it 'Returns 0 if valid date (YYYY-MM-DD)' do
      expect(bot.valid_date?('1997-12-02')).to eq(0)
    end
  end

  describe '#valid_date?' do
    it 'Returns nil if valid date (YYYY-MM-DD)' do
      expect(bot.valid_date?('1997-2-02')).to eq(nil)
    end
  end
end
