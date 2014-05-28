require 'sinatra'
require 'json'

get '/' do
  File.read('cakes.html')
end

get '/cakeList.json' do
  content_type :json
  arr = Array.new
  toPrint = ""

  File.open('cake.list', 'r') do |f1|
    while temp = f1.gets
      arr << temp.strip
    end
  end

  arr.to_json
end
