require 'sinatra'

get '/' do
  arr = Array.new
  counter = 1
  toPrint = ""

  File.open('cake.list', 'r') do |f1|
    while temp = f1.gets
      arr << counter.to_s + ") " + temp + "<br>"
      counter += 1
    end
  end
  while arr.empty? == false
    toPrint += arr.shift
  end
  toPrint
end
