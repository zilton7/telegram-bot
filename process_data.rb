require 'open-uri'
require 'libxml'
require 'net/http'
require 'nokogiri'

def get_data(month, day)
    url = "http://api.hiztory.org/births/#{month}/#{day}/1/15/api.xml"
    Net::HTTP.get_response(URI.parse(url)).body
end

def parse_data(xml_data)
    data = []
    doc = Nokogiri::XML(xml_data)
    doc.xpath('//event').each do |e|
        date = e.attr('date')
        content = e.attr('content')
        data.push({ date: date, content: content })
    end
    data
end

xml = get_data(12, 20)
data = parse_data(xml)