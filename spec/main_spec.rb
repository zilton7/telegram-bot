require_relative '../lib/process_data'

processor = DataProcessor.new

describe DataProcessor do
  describe '#gather_data' do
    it 'Returns array of parsed data' do
      expect(processor.gather_data('12', '20')).to be_a(String)
    end
  end

  describe '#parse_data' do
    it 'Returns array of parsed data' do
      expect(processor.parse_data('<xml>whatever</xml')).to be_a(Array)
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
end
