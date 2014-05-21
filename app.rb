require "sinatra"

get '/' do
  toPrint = ""
  counter = 1
  File.open('cake.list', 'r') do |f1|
    while temp = f1.gets
      toPrint = toPrint + counter.to_s + ") " + temp + "<br>"
      counter += 1
    end
  end
  toPrint
end
