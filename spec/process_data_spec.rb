require './process_data'

describe "#get_data" do
    describe "Returns array of parsed data" do
        expect(get_data('12', '20')).to be(Array)
    end
end