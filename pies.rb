require 'nokogiri'
require 'open-uri'
require 'data_mapper'
require 'dm-migrations'

DataMapper.setup(:default, 'sqlite:///tmp/test.db')

class Pie
  include DataMapper::Resource
  property :id,           Serial                      # An auto-increment integer key
  property :name,         String                      # A varchar type string, for short strings
  property :imageURL,     String, :length => 1024     # The URL to the image
  property :description,  String, :length => 1024     # The description of the pie 
end

DataMapper.finalize
DataMapper.auto_migrate!


doc = Nokogiri::HTML(open('pies.html'))

doc.css('table.wikitable tr').each do |element|
  temp = element.css('td')
  next if temp[0].nil?
  next if temp[1].css('img').length == 0
  next if temp[4].content == ""
  Pie.create(:name => temp[0].content, :imageURL => "http:" + temp[1].css('img')[0].attributes['src'], :description => temp[4].content)
end
