require 'open-uri'
require 'libxml'
require 'net/http'
require 'nokogiri'

def get_data(month, day)
    url = "http://api.hiztory.org/births/#{month}/#{day}/1/15/api.xml"
    xml = Net::HTTP.get_response(URI.parse(url)).body
    parse_data(xml)
end

def parse_data(xml_data)
    data = []
    doc = Nokogiri::XML(xml_data)
    doc.xpath('//event').each do |e|
        date = e.attr('date')
        content = e.attr('content')
        data.push({ date: date, content: content })
    end
    format_data(data)
end

def format_data(arr)
    str = "Here are the famous people born on the same day as you: \n\n"
    arr.each do |hash| 
        str += "#{ hash[:date] } --- #{ hash[:content] }\n"
    end
    str
end
